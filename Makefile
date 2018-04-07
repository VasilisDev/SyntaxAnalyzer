all:
	bison -d parser.y
	flex parser.l
	gcc parser.tab.c lex.yy.c -o parser
	./parser input.txt output.txt
clean:
	rm parser.tab.c parser.tab.h lex.yy.c parser
