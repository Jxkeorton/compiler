
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);
FILE *outfile;
%}

%union {
    int num;
    char* id;
}

%token <id> IDENTIFIER
%token <num> NUMBER
%token FUNCTION RETURN IF FOR DECLARATION
%token ASSIGN LBRACE RBRACE LPAREN RPAREN SEMICOLON COMMA
%token PLUS MINUS MULT DIV MOD
%token LBRACKET RBRACKET LT GT INCREMENT

%%

program:
    function_def
    ;

function_def:
    FUNCTION IDENTIFIER LPAREN RPAREN LBRACE statements RBRACE {
        fprintf(outfile, "void %s() {\n", $2);
        fprintf(outfile, "%s", $6);
        fprintf(outfile, "}\n");
    }
    ;

statements:
    statements statement {
        $$ = malloc(strlen($1) + strlen($2) + 1);
        strcpy($$, $1);
        strcat($$, $2);
    }
    | statement {
        $$ = $1;
    }
    ;

statement:
    RETURN expression SEMICOLON {
        $$ = malloc(strlen("return ;\n") + strlen($2) + 1);
        sprintf($$, "return %s;\n", $2);
    }
    | DECLARATION IDENTIFIER ASSIGN expression SEMICOLON {
        $$ = malloc(strlen("int = ;\n") + strlen($2) + strlen($4) + 1);
        sprintf($$, "int %s = %s;\n", $2, $4);
    }
    | DECLARATION IDENTIFIER LBRACKET NUMBER RBRACKET ASSIGN LBRACKET array_elements RBRACKET SEMICOLON {
        $$ = malloc(strlen("char* [] = { };\n") + strlen($2) + strlen($8) + 1);
        sprintf($$, "char* %s[] = { %s };\n", $2, $8);
    }
    | FOR LPAREN DECLARATION IDENTIFIER ASSIGN expression SEMICOLON expression SEMICOLON IDENTIFIER INCREMENT RPAREN LBRACE statements RBRACE {
        $$ = malloc(strlen("for (int = ; < ; ++) {\n}\n") + strlen($4) + strlen($6) + strlen($8) + strlen($12) + 1);
        sprintf($$, "for (int %s = %s; %s < %s; %s++) {\n%s}\n", $4, $6, $4, $8, $4, $12);
    }
    ;

array_elements:
    array_elements COMMA expression {
        $$ = malloc(strlen($1) + strlen($3) + 2);
        sprintf($$, "%s, %s", $1, $3);
    }
    | expression {
        $$ = $1;
    }
    ;

expression:
    expression PLUS expression {
        $$ = malloc(strlen($1) + strlen($3) + 2);
        sprintf($$, "%s + %s", $1, $3);
    }
    | expression MINUS expression {
        $$ = malloc(strlen($1) + strlen($3) + 2);
        sprintf($$, "%s - %s", $1, $3);
    }
    | expression MULT expression {
        $$ = malloc(strlen($1) + strlen($3) + 2);
        sprintf($$, "%s * %s", $1, $3);
    }
    | expression DIV expression {
        $$ = malloc(strlen($1) + strlen($3) + 2);
        sprintf($$, "%s / %s", $1, $3);
    }
    | expression MOD expression {
        $$ = malloc(strlen($1) + strlen($3) + 2);
        sprintf($$, "%s %% %s", $1, $3);
    }
    | IDENTIFIER {
        $$ = $1;
    }
    | NUMBER {
        $$ = malloc(12);
        sprintf($$, "%d", $1);
    }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Parse error: %s\n", s);
}

int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <output file>\n", argv[0]);
        return 1;
    }

    outfile = fopen(argv[1], "w");
    if (!outfile) {
        perror("fopen");
        return 1;
    }

    yyparse();
    fclose(outfile);
    return 0;
}
