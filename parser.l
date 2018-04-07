/* Onoma arxeiou:	parser.l
   Perigrafh:		lektikou analyth me xrhsh tou ergaleiou Flex
   Syggrafeas:		vasilis Tsakiris 151082
   Sxolia:		To paron programma ylopoiei (me th xrhsh Flex) enan lektiko analuth ths glwssas tei python
*/

%option noyywrap
%x error

%{
/*_________________________________________________

  Kwdikas C gia orismo twn apaitoumenwn header files
  kai twn metablhtwn
_________________________________________________*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "parser.tab.h"

extern int linenum ;
void yyerror( char *);
void ERROR(const char *msg);
int curr_line = 1;
char strline[100];
extern int line;
%}

/* _____________________________________________

                  perioxi orismWn
________________________________________________*/
/* DELIMITERS */
TAB			[\t]+
SPACE			[ ]+
DELIMITER		{SPACE}|{TAB}

/*SYMBOLS*/
SYMBOL	[\_\{\}\!\&\~\.\$\?]+


/* KEYWORDS */
KEYWORD			(False|class|finally|is|None|continue|lambda|try|True|from|nonlocal|and|global|not|with|as|or|yield|assert|import|passbreak|except|in|raise)

R_FOR for
R_IF if
R_WHILE while
R_ELSE else
R_ELIF elif
R_DEL del
R_LEN len
R_CMP cmp
R_PRINT print
R_INPUT input
R_RETURN return
R_TYPE type


/* IDENTIFIERS */
ID 			[A-Za-z_][A-Za-z_0-9]*
ID_ERR			[0-9]{ID}

/* COMMENTS */
COMMENT 		#.*\n

/* STRINGS */
STRINGESCAPESEQ		[\\].
SHORTSTRINGCHAR1	[^\\'\n]*
SHORTSTRINGCHAR2	[^\\"\n]*
SHORTSTRINGITEM1	{SHORTSTRINGCHAR1}|{STRINGESCAPESEQ}
SHORTSTRINGITEM2	{SHORTSTRINGCHAR2}|{STRINGESCAPESEQ}
STRING			[']{SHORTSTRINGITEM1}*[']|(["]{SHORTSTRINGITEM2}*["])
STRING_ERR		['].[^'\n\t]*|["].[^"\n\t]*


/* INTEGERS */
DIGIT 			[0-9]
NONZERODIGIT 		[1-9]
DECIMALINTEGER 		{NONZERODIGIT}{DIGIT}*|[0]+
INTEGER			{DECIMALINTEGER}
INTEGER_ERR_LETTER	{INTEGER}[a_zA-z]+
INTEGER_ERR_SIGN	[-+]{INTEGER}
INTEGER_ERR_ZERO	[0]+{INTEGER}

/* FLOATING POINT NUMBERS */
EXPONENT		[eE][+-]*{DIGIT}+
FRACTION		[\.]{DIGIT}+
INTPART			{DIGIT}+
EXPONENTFLOAT		({INTPART}|{POINTFLOAT}){EXPONENT}
POINTFLOAT		{INTPART}*{FRACTION}|{INTPART}[\.]
FLOATNUMBER		{POINTFLOAT}|{EXPONENTFLOAT}
FLOATNUMBER_ERR_POINT	{INTPART}*[\.]+{DIGIT}+[\.]*{DIGIT}*|{INTPART}[\.]+
FLOATNUMBER_ERR_SIGN	([-+]{FLOATNUMBER})
FLOATNUMBER_ERR_LETTR   {FLOATNUMBER}[A-Za-z]+



/* ______________________________________________

                  perioxi kanonwn
_________________________________________________*/
%%

{DELIMITER}	{ }                       //agnoei tous lefkous xarakthres

{SYMBOL}	{ return SYMBOL; }

";"		{ return SEMI; }

"+"		{ return PLUS; }

"-"		{ return MINUS; }

"*"		{ return MULT; }

"/"		{ return DIV; }

"("		{ return L_PA; }

")"		{ return R_PA; }

"="		{ return EQ; }

"\^"		{ return DYN; }

">"		{ return BIG; }

"<"		{ return SMALL; }

">="	        { return BIG_EQ; }

"<="		{ return SMALL_EQ;}

"!="		{ return DIFF; }

"["	        { return R_AGK; }

"]"			{ return L_AGK; }

","			{ return COMMA; }
":"                  {return COLON;}


{KEYWORD}		{ return KEYWORD; }

{R_FOR}		      { return R_FOR; }

{R_IF}		        { return R_IF; }

{R_WHILE}		{ return R_WHILE; }

{R_ELSE}		{ return R_ELSE; }

{R_ELIF}		{ return R_ELIF; }

{R_LEN}			{ return R_LEN; }

{R_CMP}			{ return R_CMP; }

{R_PRINT}		{ return R_PRINT; }

{R_INPUT}               { return R_INPUT; }

{R_RETURN}		{ return R_RETURN; }


{R_TYPE}                { return R_TYPE;}

{COMMENT}		{ printf("Line%d: Comment found and ignored!\n", line); fprintf(yyout,"%d: Comment found and ignored!\n", line); }

{ID}			{ printf("Line%d: Identifier found: %s\n", line, yytext); fprintf(yyout,"%d: Identifier found: %s\n", line, yytext);return ID;}

{STRING}		{ printf("Line%d: String found: %s\n", line, yytext); fprintf(yyout,"%d: String found: %s\n", line, yytext);return STRING;}

{STRING_ERR}		{ yyerror("ERROR! Illegal String statement - Missing quote at the end:"); 	BEGIN(error); return STRING_ERR;}

{INTEGER}		{ printf("Line%d: Integer found: %s\n", line, yytext); fprintf(yyout,"%d: Integer found: %s\n", line, yytext); return INTEGER;}

{INTEGER_ERR_LETTER}	{ yyerror("ERROR! Illegal Integer statement - Ends with a letter:"); 		BEGIN(error); return INTEGER_ERR_LETTER;}

{INTEGER_ERR_SIGN}	{ yyerror("ERROR! Illegal Integer statement - Initial character is a sign:"); 	BEGIN(error); return INTEGER_ERR_SIGN;}

{INTEGER_ERR_ZERO}	{ yyerror("ERROR! Illegal Integer statement - Initial character is Zero:"); 	BEGIN(error); return INTEGER_ERR_ZERO;}

{FLOATNUMBER}		{ printf("Line%d: Floating Point Number found: %s\n", line, yytext); fprintf(yyout,"%d: Floating Point Number found: %s\n", line, yytext);return FLOATNUMBER;}


{FLOATNUMBER_ERR_POINT}	{ yyerror("ERROR! Illegal Float statement - Contains more than one '.' :"); 	BEGIN(error); return FLOATNUMBER_ERR_POINT;}

{FLOATNUMBER_ERR_SIGN}	{ yyerror("ERROR! Illegal Float statement - Initial character is a sign:"); 	BEGIN(error); return FLOATNUMBER_ERR_SIGN;}

{FLOATNUMBER_ERR_LETTR} { yyerror("ERROR! Illegal Float statement - Ends with a letter:"); 		BEGIN(error); return FLOATNUMBER_ERR_LETTR;}
. 			{ yyerror("UNKNOWN TOKEN:"); 							BEGIN(error); }
\n              	{ line++;} //metrhths o opoios metraei tis grammes toy arxeiou
<<EOF>>			{ printf("#END OF FILE\n"); fprintf(yyout,"#END OF FILE\n"); exit(0); }
<error>[ \t]		{ BEGIN(0); }
<error>[\n]		{ line++; BEGIN(0); }
<error>.                { }

%%

void yyerror( char* err)
{
        fprintf(stderr, "Line %d: %s '%s' \n", line, err, yytext );
        fprintf(yyout, "At line %d. %s '%s' \n", line, err, yytext );
}
