%{
#include "listing.h"
#include "tokens.h"
#include <cstdio>
#include <string>
#include <cctype>
void yyerror(const char* msg);
int yylex(void);
%}

%token IDENTIFIER
%token INTEGER_LIT HEX_LIT REAL_LIT CHAR_LIT
%token FUNCTION RETURNS BEGIN_ END
%token IF THEN ELSIF ELSE ENDIF
%token FOLD ENDFOLD LEFT RIGHT
%token SWITCH IS CASE OTHERS ENDSWITCH ARROW
%token WHEN
%token LIST OF
%token INTEGER REAL CHARACTER
%token ADDOP MULOP REMOP EXPOP NEGOP
%token NOTOP ANDOP OROP RELOP
%token LPAREN "(" RPAREN ")" LBRACKET "[" RBRACKET "]"
%token COMMA "," 
%token COLON ":" 
%token SEMICOLON ";"

%start program
%define parse.error verbose

%%

program
  : function
  | program function
  ;

function
  : FUNCTION IDENTIFIER header_vars RETURNS type SEMICOLON variable_opt body
  ;

variable_opt
  : /* empty */
  | variable_list
  ;

variable_list
  : variable
  | variable_list variable
  | variable_list error
  ;

header_vars
  : /* empty */
  | parameter_list
  ;

parameter_list
  : parameter
  | parameter_list COMMA parameter
  ;

parameter
  : IDENTIFIER COLON type
  | IDENTIFIER error type
  ;

variable
  : IDENTIFIER COLON type IS expression SEMICOLON
  | IDENTIFIER COLON LIST OF type IS list_literal SEMICOLON
  | IDENTIFIER error
  ;

type
  : INTEGER
  | REAL
  | CHARACTER
  ;

body
  : BEGIN_ statement_list END SEMICOLON
  ;

statement_list
  : statement
  | statement_list statement
  ;

statement
  : expression SEMICOLON
  | WHEN condition COMMA expression COLON expression SEMICOLON
  | IF condition THEN statement_list elsif_tail else_opt ENDIF SEMICOLON
  | SWITCH expression IS case_list OTHERS ARROW statement ENDSWITCH SEMICOLON
  | SWITCH expression IS case_list error ENDSWITCH SEMICOLON
  | SWITCH expression IS error ENDSWITCH SEMICOLON
     { appendError(SYNTAX, "Unexpected ENDSWITCH, expecting CASE or OTHERS"); }
  | FOLD direction operator fold_target ENDFOLD SEMICOLON
  | error SEMICOLON
  ;

elsif_tail
  : /* empty */
  | elsif_tail ELSIF condition THEN statement_list
  ;

else_opt
  : /* empty */
  | ELSE statement_list
  ;

cases
  : /* empty */
  | case_list
  ;

case_list
  : case_item
  | case_list case_item
  ;

case_item
  : CASE INTEGER_LIT ARROW statement
  | CASE INTEGER_LIT ARROW error SEMICOLON
  ;

direction
  : LEFT
  | RIGHT
  ;

operator
  : ADDOP
  | MULOP
  ;

fold_target
  : list_literal
  | IDENTIFIER
  ;

list_literal
  : LPAREN expr_list RPAREN
  ;

expr_list
  : expression
  | expr_list COMMA expression
  ;

condition
  : expression
  ;

expression
  : or_expr
  ;

or_expr
  : and_expr
  | or_expr OROP and_expr
  ;

and_expr
  : rel_expr
  | and_expr ANDOP rel_expr
  ;

rel_expr
  : add_expr
  | rel_expr RELOP add_expr
  ;

add_expr
  : mul_expr
  | add_expr ADDOP mul_expr
  ;

mul_expr
  : exp_expr
  | mul_expr MULOP exp_expr
  | mul_expr REMOP exp_expr
  ;

exp_expr
  : neg_expr
  | neg_expr EXPOP exp_expr
  ;

neg_expr
  : not_expr
  | NEGOP neg_expr
  | ADDOP neg_expr
  ;

not_expr
  : primary
  | NOTOP not_expr
  ;

designator
  : IDENTIFIER
  | designator LPAREN expression RPAREN
  ;

primary
  : designator
  | INTEGER_LIT
  | HEX_LIT
  | REAL_LIT
  | CHAR_LIT
  | LPAREN expression RPAREN
  ;

%%

void yyerror(const char* msg) {
  std::string s = msg ? msg : "";
  const std::string lead = "syntax error, ";
  std::string lower = s;
  for (char& ch : lower) ch = std::tolower(static_cast<unsigned char>(ch));
  if (lower.rfind(lead, 0) == 0) s.erase(0, lead.size());
  if (!s.empty()) s[0] = std::toupper(static_cast<unsigned char>(s[0]));
  appendError(SYNTAX, s);
}
