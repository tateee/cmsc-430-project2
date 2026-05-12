%{
#include <string>
#include <cstring>
#include <cstdlib>
#include "listing.h"
#include "tokens.h"
#include "types.h"
using namespace std;

int lineNumber = 1;
%}

letter      [A-Za-z]
digit       [0-9]
id          {letter}({letter}|{digit}|_)*
dec         {digit}+
hex         0[xX][0-9A-Fa-f]+
real        {digit}+"."{digit}*([eE][+-]?{digit}+)?
char        \'([^\'\\]|\\.)\'
ws          [ \t\r]+
newline     \n

%%

{ws}            ;
{newline}       { nextLine(); lineNumber++; }
"--".*          { nextLine(); }

"function"      { ECHO; return(FUNCTION); }
"returns"       { ECHO; return(RETURNS); }
"begin"         { ECHO; return(BEGIN_); }
"end"           { ECHO; return(END); }
"if"            { ECHO; return(IF); }
"then"          { ECHO; return(THEN); }
"elsif"         { ECHO; return(ELSIF); }
"else"          { ECHO; return(ELSE); }
"endif"         { ECHO; return(ENDIF); }
"fold"          { ECHO; return(FOLD); }
"endfold"       { ECHO; return(ENDFOLD); }
"left"          { ECHO; return(LEFT); }
"right"         { ECHO; return(RIGHT); }
"switch"        { ECHO; return(SWITCH); }
"is"            { ECHO; return(IS); }
"case"          { ECHO; return(CASE); }
"others"        { ECHO; return(OTHERS); }
"endswitch"     { ECHO; return(ENDSWITCH); }
"when"          { ECHO; return(WHEN); }
"list"          { ECHO; return(LIST); }
"of"            { ECHO; return(OF); }
"integer"       { ECHO; return(INTEGER); }
"real"          { ECHO; return(REAL); }
"character"     { ECHO; return(CHARACTER); }

"and"           { ECHO; return(ANDOP); }
"or"            { ECHO; return(OROP); }
"not"           { ECHO; return(NOTOP); }

"+"             { ECHO; return(ADDOP); }
"-"             { ECHO; return(ADDOP); }
"*"             { ECHO; return(MULOP); }
"/"             { ECHO; return(MULOP); }
"%"             { ECHO; return(REMOP); }
"^"             { ECHO; return(EXPOP); }
"~"             { ECHO; return(NEGOP); }

"="             { ECHO; return(RELOP); }
"/="            { ECHO; return(RELOP); }
"<"             { ECHO; return(RELOP); }
"<="            { ECHO; return(RELOP); }
">"             { ECHO; return(RELOP); }
">="            { ECHO; return(RELOP); }

"("             { ECHO; return(LPAREN); }
")"             { ECHO; return(RPAREN); }
"["             { ECHO; return(LBRACKET); }
"]"             { ECHO; return(RBRACKET); }
","             { ECHO; return(COMMA); }
":"             { ECHO; return(COLON); }
";"             { ECHO; return(SEMICOLON); }
"=>"            { ECHO; return(ARROW); }

{id}            { ECHO; yylval.text = strdup(yytext); return(IDENTIFIER); }
{dec}           { ECHO; yylval.type = INT_TYPE; return(INTEGER_LIT); }
{hex}           { ECHO; yylval.type = INT_TYPE; return(HEX_LIT); }
{real}          { ECHO; yylval.type = REAL_TYPE; return(REAL_LIT); }
{char}          { ECHO; yylval.type = CHAR_TYPE; return(CHAR_LIT); }

.               { appendError(LEXICAL, "Invalid character"); }

%%

int yywrap() { return 1; }
