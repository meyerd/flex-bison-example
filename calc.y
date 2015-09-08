%{

#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}

%union {
	int ival;
	float fval;
}

%token<ival> T_INT
%token<fval> T_FLOAT
%token T_PLUS T_MINUS T_MULTIPLY T_DIVIDE T_LEFT T_RIGHT
%token T_NEWLINE T_QUIT
%left T_PLUS T_MINUS
%left T_MULTIPLY T_DIVIDE

%type<ival> expression
%type<ival> float_expression


%start calculation

%%

calculation: 
	   | calculation line
;

line: T_NEWLINE
    | float_expression T_NEWLINE {printf("\tResult: %f\n", (float) $1);}
    | expression T_NEWLINE { printf("\tResult: %i\n", $1); } 
    | T_QUIT T_NEWLINE { printf("bye!\n"); exit(0); }
;

float_expression: T_FLOAT                 { $$ = $1; }
	  | float_expression T_PLUS float_expression	{ $$ = $1 + $3; }
	  | float_expression T_MINUS float_expression	{ $$ = $1 - $3; }
	  | float_expression T_MULTIPLY float_expression	{ $$ = $1 * $3; }
	  | float_expression T_DIVIDE float_expression	{ $$ = $1 / $3; }
	  | T_LEFT float_expression T_RIGHT		{ $$ = $2; }


expression: T_INT				{ $$ = $1; }
	  | expression T_PLUS expression	{ $$ = $1 + $3; }
	  | expression T_MINUS expression	{ $$ = $1 - $3; }
	  | expression T_MULTIPLY expression	{ $$ = $1 * $3; }
	  | expression T_DIVIDE expression	{ $$ = $1 / $3; }
	  | T_LEFT expression T_RIGHT		{ $$ = $2; }
  ;

%%

main() {
	yyin = stdin;

	do { 
		yyparse();
	} while(!feof(yyin));
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}
