
#include <stdio.h>

extern int yyparse();

int main() {
    printf("Parsing JavaScript Caesar Cipher...\n");
    if (yyparse() == 0) {
        printf("Parsing completed successfully.\n");
    } else {
        printf("Parsing failed.\n");
    }
    return 0;
}
