/* Onoma arxeiou:	parser.y
   Perigrafh:		Aplos syntaktikos analyths (kwdikas gia to ergaleio Bison)
   Syggrafeas:	Vasilis Tsakiris 151082	

*/

%{
/*_________________________________________________

Perioxi diloseon C kodika syntaktikoy analyti
(bibliothikes klp)
_________________________________________________*/

	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
        int yylex();
	int line = 1;
	int linenum = 1; //metrima grammwn arxeiou sto Flex
	void yyerror(char *s); //yyeror ->flex
	extern void ERROR(const char *msg);
	extern char *yytext; //yytext -> flex
	#define YYSTYPE char*
	extern int curr_line;
	extern char strline[100];  // strline -> flex
        FILE *yyin, *yyout;  // gia xrhsh twn arxeiwn
	char error[100];  /* emfanish smalmatos kai klhsh ths yyerror*/
%}

/* _____________________________________________

       perioxi dilosis tokens
________________________________________________*/
%error-verbose
%token KEYWORD SEMI PLUS MINUS MULT DIV L_PA R_PA EQ DYN R_FOR R_IF R_WHILE R_ELSE R_ELIF DELIMITER SYMBOL COMMENT ID ID_ERR STRING
STRING_ERR INTEGER INTEGER_ERR_LETTER INTEGER_ERR_SIGN INTEGER_ERR_ZERO FLOATNUMBER
 FLOATNUMBER_ERR_LETTR FLOATNUMBER_ERR_SIGN FLOATNUMBER_ERR_POINT R_TYPE R_LEN R_CMP R_PRINT R_INPUT R_RETURN R_AGK L_AGK COMMA COLON
BIG_EQ BIG SMALL SMALL_EQ DIFF UNKNOWN
//Dhlwsh proteraiothtwn
%right EQ
%left L_PA R_PA
%left MULT DIV
%left MINUS PLUS
/* ______________________________________________

       dilosi start condition
_________________________________________________*/
%start program


%%


/* ______________________________________________

      perioxi kanonwn --> onoma : kanonas { kwdikas C }
_________________________________________________*/
program :
        | program assign
        | program syn
       	| program condition
	| program loop
	| program merge
	| error {yyclearin; yyerrok; sprintf(error, "line %d: FAILED %d, %s", curr_line, 101, strline);}
     ;
assign :  ID EQ ATOM SEMI {fprintf(yyout, "line %d: SUCCESSFUL 'assignment', %s\n",line, strline); strcpy(strline, ""); }
	| ID EQ ATOM praxeis ATOM SEMI  {fprintf(yyout, "line %d: SUCCESSFUL 'assignment'\n",line); strcpy(strline, ""); }
	| ID EQ L_PA exp3 R_PA  {fprintf(yyout, "line %d: SUCCESSFUL 'assignment'\n",line); strcpy(strline, ""); }


	;
condition : R_IF exp {fprintf(yyout, "line %d: SUCCESSFUL 'if' syntax, %s\n",line, strline); strcpy(strline, ""); }
            |error
          ;
loop : R_FOR L_PA ID EQ ATOM SEMI ID COMP ATOM SEMI ID EQ ID praxeis ATOM SEMI R_PA
	{fprintf(yyout, "line %d: SUCCESSFUL 'for' syntax, %s\n",line, strline); strcpy(strline, ""); }
	| R_WHILE L_PA ID COMP ATOM R_PA {fprintf(yyout, "line %d: SUCCESSFUL 'while' syntax, %s\n",line, strline); strcpy(strline, ""); }

        ;


 syn :
          R_TYPE L_PA exp4 R_PA SEMI{fprintf(yyout, "line %d: SUCCESSFUL 'type' syntax, %s\n",line, strline); strcpy(strline, ""); }
	| R_LEN L_PA  exp3 R_PA SEMI{fprintf(yyout, "line %d: SUCCESSFUL 'len' syntax, %s\n",line, strline); strcpy(strline, ""); }
        | R_LEN L_PA  praxeis num R_PA SEMI{fprintf(yyout, "line %d: SUCCESSFUL 'len' syntax, %s\n",line, strline); strcpy(strline, ""); }
	| R_CMP L_PA ID COMMA L_PA exp3 R_PA R_PA SEMI{fprintf(yyout, "line %d: SUCCESSFUL 'cmp' syntax, %s\n",line, strline); strcpy(strline, ""); }
	| R_CMP L_PA L_PA exp3 R_PA COMMA L_PA exp3 R_PA R_PA SEMI {fprintf(yyout, "line %d: SUCCESSFUL 'cmp' syntax, %s\n",line, strline); strcpy(strline, ""); }
	| R_CMP L_PA ID COMMA ID R_PA SEMI {fprintf(yyout, "line %d: SUCCESSFUL 'cmp' syntax, %s\n",line, strline); strcpy(strline, ""); }
	| R_CMP L_PA L_PA exp3 R_PA COMMA ID R_PA SEMI{fprintf(yyout, "line %d: SUCCESSFUL 'cmp' syntax, %s\n",line, strline); strcpy(strline, ""); }
	| R_PRINT L_PA STRING R_PA SEMI {fprintf(yyout, "line %d: SUCCESSFUL 'print' syntax, %s\n",line, strline); strcpy(strline, ""); }
	| R_PRINT L_PA ID COMMA L_PA exp3 R_PA R_PA SEMI{fprintf(yyout, "line %d: SUCCESSFUL'print' syntax, %s\n",line, strline); strcpy(strline, ""); }
	| R_PRINT L_PA L_PA exp3 R_PA COMMA L_PA exp3 R_PA R_PA SEMI{fprintf(yyout, "line %d: SUCCESS 'print' syntax, %s\n",line, strline); strcpy(strline, ""); }
	| R_PRINT L_PA ID COMMA ID R_PA  SEMI{fprintf(yyout, "line %d: SUCCESSFUL 'print' syntax, %s\n",line, strline); strcpy(strline, ""); }
	| R_PRINT L_PA L_PA exp3 R_PA COMMA ID R_PA SEMI{fprintf(yyout, "line %d: SUCCESSFUL 'print' syntax, %s\n",line, strline); strcpy(strline, ""); }
        | R_INPUT L_PA STRING R_PA SEMI {fprintf(yyout, "line %d: SUCCESSFUL 'input' syntax , %s\n",line, strline); strcpy(strline, ""); }
        | R_INPUT L_PA ID COMMA  R_PA SEMI{fprintf(yyout, "line %d: SUCCESSFUL 'input' syntax, %s\n",line, strline); strcpy(strline, ""); }
	| R_INPUT L_PA ID COMMA L_PA exp3 R_PA R_PA SEMI{fprintf(yyout, "line %d: SUCCESSFUL 'input' syntax, %s\n",line, strline); strcpy(strline, ""); }
	| R_INPUT L_PA L_PA exp3 R_PA COMMA L_PA exp3 R_PA R_PA SEMI {fprintf(yyout, "line %d: SUCCESSFUL 'input' syntax, %s\n",line, strline); strcpy(strline, ""); }
	| R_INPUT L_PA ID COMMA ID R_PA  SEMI {fprintf(yyout, "line %d: SUCCESSFUL 'input' syntax, %s\n",line, strline); strcpy(strline, ""); }
	| R_INPUT L_PA L_PA exp3 R_PA COMMA ID R_PA SEMI {fprintf(yyout, "line %d: SUCCESSFUL 'input' syntax, %s\n",line, strline); strcpy(strline, ""); }

        ;
merge :  L_PA exp3 R_PA PLUS L_PA exp3 R_PA
        |exp3 R_PA PLUS L_PA exp3 R_PA
        |L_PA exp3 R_PA PLUS L_PA exp3
        |L_PA exp3  PLUS L_PA exp3 R_PA
        | L_PA exp3 R_PA PLUS exp3 R_PA
        ;

ATOM:     ID
	| INTEGER
	| FLOATNUMBER
	;

num :     INTEGER
	| FLOATNUMBER

	 ;

COMP :    BIG
	| SMALL
	| EQ
	| SMALL_EQ
	| BIG_EQ
	| DIFF
          ;
praxeis : MULT
	| DIV
	| MINUS
	| PLUS
         ;
exp :	L_PA ATOM COMP ATOM R_PA
         ;
exp1 : num COMMA
         ;
exp2 :    STRING COMMA
         |STRING
         ;
exp3 : exp1
	| exp1 exp2
	| exp2
	| exp2 exp1
         ;
exp4 : ID COMMA
	| ID
         ;
%%
/* O deikths yyin einai autos pou "deixnei" sto arxeio eisodou. Ean den ginei xrhsh
   tou yyin, tote h eisodos ginetai apokleistika apo to standard input (plhktrologio) */

FILE *yyin;

/* ____________________________________________________

H synarthsh main pou apotelei kai to shmeio ekkinhshs tou programmatos poy tha 'gennithei'. Ginetai klhsh ths yyparse pou pragmatopoiei thn syntaktikh analysh. Sto telos ginetai elegxos gia thn epityxh h mh ekbash ths analyshs.
________________________________________________________*/


int main(int argc, char **argv){
	int token;
//Edw ginetai o elegxos twn orismatwn
	if(argc == 1){// an dwsei ena orisma emfanizei sto xrhsth ena mhnuma gia thn xrhsei ton iput kai output arxeiwn
		printf("Syntax: %s input-file [output-file]\n", argv[0]);//h emfanish tou mhnumatos
		return -1;
	}

	if(argc == 3){// an dwsei input+output tote ta anigei kai ta 2
		if(!(yyin = fopen(argv[1], "r"))) {//elegxos arxeiou
			fprintf(stderr, "Cannot read file: %s\n", argv[1]);//sfalma arxeiou
			return 1;
		}
		if(!(yyout = fopen(argv[2], "w"))) { //elegxos arxeiou
			fprintf(stderr, "Cannot create file: %s\n", argv[2]);//sfalma arxeiou
			return 1;
		}
	}
	else if(argc == 2){
		if(!(yyin = fopen(argv[1], "r"))) {
			fprintf(stderr, "Cannot read file: %s\n", argv[1]);
			return 1;
		}
	}
    int ret = yyparse();
if (ret != 0)// an h synarthsh yyparse() epistrepsei 1 tote h analush termatizetai
		printf("Parse failed...\n");

  return 0;

}
