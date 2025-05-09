
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);
%}

%union {
    int num;
    char* id;
}

%token <id> IDENTIFIER
%token <num> NUMBER
%token FUNCTION RETURN IF FOR DECLARATION
%token ASSIGN LBRACE RBRACE LPAREN RPAREN SEMICOLON COMMA
%token PLUS MINUS MULT DIV MOD LBRACKET RBRACKET LT GT INCREMENT

%%

program:
    function_def
    ;

function_def:
    FUNCTION IDENTIFIER LPAREN RPAREN LBRACE statements RBRACE
    ;

statements:
    statements statement
    | statement
    ;

statement:
    RETURN expression SEMICOLON
    | DECLARATION IDENTIFIER ASSIGN expression SEMICOLON
    | FOR LPAREN DECLARATION IDENTIFIER ASSIGN expression SEMICOLON expression SEMICOLON IDENTIFIER INCREMENT RPAREN LBRACE statements RBRACE
    ;

expression:
    expression PLUS expression
    | expression MINUS expression
    | expression MULT expression
    | expression DIV expression
    | expression MOD expression
    | IDENTIFIER LBRACKET expression RBRACKET
    | NUMBER
    | IDENTIFIER
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Parse error: %s\n", s);
}
