%{
   #include <stdio.h>
   #include <math.h>
%}


%token <anInt>	INTEGER NEWLINE LOG EXP                // Declaration of Tokens
%type <anInt>	S E T F                                  // Declaration of Types
%right LOG EXP '^'                                     // Declaration right association

%union { float anInt; }                                // create an union of numbers

%%
S:
  { $$ = 0; }                                          // initizialize stack to 0
	|S E NEWLINE                                         // if stack = { 0 EXPRESSION NEWLINE }
	{ printf("Result is %lf\n", $2); $$ = $2; }          // display results = element_2
	;

E: 
  E '+' F                                              // if EXPRESSION = EXPRESSION + FACTOR
	{ $$ = $1 + $3; }                                    // push result = element_1 + element_3 to stack
	| T                                                  // or if TERM
	{ $$ = $1; }                                         // push element_1 to stack
	| E '/' F                                            // if EXPRESSION = EXPRESSION / FACTOR
	{ $$ = $1 / $3; }                                    // push result = element_1 / element_3 to stack
	| E '-' F                                            // if EXPRESSION = EXPRESSION - FACTOR
	{ $$ = $1 - $3; }                                    // push result = element_1 - element_3 to stack
	;

T: 
  T '*' F                                              // if TERM = TERM * FACTOR
  { $$ = $1 * $3; }                                    // push result = element_1 + element_3 to stack
  | F                                                  // if FACTOR
  { $$ = $1; }                                         // push element_1 to stack
  | F '^' F                                            // if FACTOR ^ FACTOR
  { $$ = pow($1, $3); }                                // push result = pow(element_1, element_3) to stack
  ;

F: 
   '('E')'                                             // if FACTOR = (EXPRESSION)
   { $$ = $2; }                                        // push element_2 to stack
   | LOG'('E')'                                        // if FACTOR = log(EXPRESSION)
   { $$ = log($3); }                                   // push result = log(element_3) to stack
   | EXP'('E')'                                        // if FACTOR = exp(EXPRESSION)
   { $$ = exp($3); }                                   // push result = exp(element_3) to stack
   | INTEGER                                           // if FACTOR = INTEGER
   { $$ = $1; }                                        // push element_1 to stack
   ;

%%
int yyerror( char * s )                                // error function
{
    fprintf( stderr, "%s\n", s );                      // display error to display
    return 0;                                          // exit with signal 0
}
