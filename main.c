
#include <stdio.h>
#include <stdlib.h>

extern int yyparse();
extern FILE *yyin;

int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror(argv[1]);
            return 1;
        }
    } else {
        yyin = stdin;
    }

    printf("Parsing JavaScript Caesar Cipher...
");
    if (yyparse() == 0) {
        printf("Parsing completed successfully.
");
    } else {
        printf("Parsing failed.
");
    }

    return 0;
}
