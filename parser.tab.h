/* A Bison parser, made by GNU Bison 3.0.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_PARSER_TAB_H_INCLUDED
# define YY_YY_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    KEYWORD = 258,
    SEMI = 259,
    PLUS = 260,
    MINUS = 261,
    MULT = 262,
    DIV = 263,
    L_PA = 264,
    R_PA = 265,
    EQ = 266,
    DYN = 267,
    R_FOR = 268,
    R_IF = 269,
    R_WHILE = 270,
    R_ELSE = 271,
    R_ELIF = 272,
    DELIMITER = 273,
    SYMBOL = 274,
    COMMENT = 275,
    ID = 276,
    ID_ERR = 277,
    STRING = 278,
    STRING_ERR = 279,
    INTEGER = 280,
    INTEGER_ERR_LETTER = 281,
    INTEGER_ERR_SIGN = 282,
    INTEGER_ERR_ZERO = 283,
    FLOATNUMBER = 284,
    FLOATNUMBER_ERR_LETTR = 285,
    FLOATNUMBER_ERR_SIGN = 286,
    FLOATNUMBER_ERR_POINT = 287,
    R_TYPE = 288,
    R_LEN = 289,
    R_CMP = 290,
    R_PRINT = 291,
    R_INPUT = 292,
    R_RETURN = 293,
    R_AGK = 294,
    L_AGK = 295,
    COMMA = 296,
    COLON = 297,
    BIG_EQ = 298,
    BIG = 299,
    SMALL = 300,
    SMALL_EQ = 301,
    DIFF = 302,
    UNKNOWN = 303
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */
