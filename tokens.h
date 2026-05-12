/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

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

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_PARSER_TAB_H_INCLUDED
# define YY_YY_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    IDENTIFIER = 258,              /* IDENTIFIER  */
    INTEGER_LIT = 259,             /* INTEGER_LIT  */
    HEX_LIT = 260,                 /* HEX_LIT  */
    REAL_LIT = 261,                /* REAL_LIT  */
    CHAR_LIT = 262,                /* CHAR_LIT  */
    FUNCTION = 263,                /* FUNCTION  */
    RETURNS = 264,                 /* RETURNS  */
    BEGIN_ = 265,                  /* BEGIN_  */
    END = 266,                     /* END  */
    IF = 267,                      /* IF  */
    THEN = 268,                    /* THEN  */
    ELSIF = 269,                   /* ELSIF  */
    ELSE = 270,                    /* ELSE  */
    ENDIF = 271,                   /* ENDIF  */
    FOLD = 272,                    /* FOLD  */
    ENDFOLD = 273,                 /* ENDFOLD  */
    LEFT = 274,                    /* LEFT  */
    RIGHT = 275,                   /* RIGHT  */
    SWITCH = 276,                  /* SWITCH  */
    IS = 277,                      /* IS  */
    CASE = 278,                    /* CASE  */
    OTHERS = 279,                  /* OTHERS  */
    ENDSWITCH = 280,               /* ENDSWITCH  */
    ARROW = 281,                   /* ARROW  */
    WHEN = 282,                    /* WHEN  */
    LIST = 283,                    /* LIST  */
    OF = 284,                      /* OF  */
    INTEGER = 285,                 /* INTEGER  */
    REAL = 286,                    /* REAL  */
    CHARACTER = 287,               /* CHARACTER  */
    ADDOP = 288,                   /* ADDOP  */
    MULOP = 289,                   /* MULOP  */
    REMOP = 290,                   /* REMOP  */
    EXPOP = 291,                   /* EXPOP  */
    NEGOP = 292,                   /* NEGOP  */
    NOTOP = 293,                   /* NOTOP  */
    ANDOP = 294,                   /* ANDOP  */
    OROP = 295,                    /* OROP  */
    RELOP = 296,                   /* RELOP  */
    LPAREN = 297,                  /* "("  */
    RPAREN = 298,                  /* ")"  */
    LBRACKET = 299,                /* "["  */
    RBRACKET = 300,                /* "]"  */
    COMMA = 301,                   /* ","  */
    COLON = 302,                   /* ":"  */
    SEMICOLON = 303                /* ";"  */
  };
  typedef enum yytokentype yytoken_kind_t;
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
