
all:
	bison -d cipher.y
	flex cipher.l
	gcc -o cipher_compiler cipher.tab.c lex.yy.c main.c -lfl
