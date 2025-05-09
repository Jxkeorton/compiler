
%{
#include "cipher.tab.h"
%}

%%
"function"     { return FUNCTION; }
"let"|"const"  { return DECLARATION; }
"if"           { return IF; }
"for"          { return FOR; }
"return"       { return RETURN; }
"="            { return ASSIGN; }
"{"            { return LBRACE; }
"}"            { return RBRACE; }
"("            { return LPAREN; }
")"            { return RPAREN; }
";"            { return SEMICOLON; }
","            { return COMMA; }
"+"            { return PLUS; }
"-"            { return MINUS; }
"*"            { return MULT; }
"/"            { return DIV; }
"%"            { return MOD; }
"["            { return LBRACKET; }
"]"            { return RBRACKET; }
"<"            { return LT; }
">"            { return GT; }
"++"           { return INCREMENT; }
[0-9]+         { yylval.num = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.id = strdup(yytext); return IDENTIFIER; }
[ 	
]+       { /* skip whitespace */ }
.              { return yytext[0]; }
%%
