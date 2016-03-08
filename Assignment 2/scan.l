%{
   #include <stdio.h>
   #include "gram.h"

   #undef yywrap
   int yywrap();
%}
/* extern YYSTYPE yylval; */

%%
[ \t\r];
[0-9]+[.]?[0-9]* {
    	yylval.anInt = atof((char *)&yytext[0]);   // get inputed string and covert to float
	    return INTEGER;                            // return INTEGER
}

log return LOG;                                  // if log then return LOG
exp return EXP;                                  // if exp then return EXP
\n	return NEWLINE;                              // if \n then return NEWLINE
.	return *yytext;                                // if . then return string

%%
int yywrap()                                     // yywrapper
{
    return 1;                                    // return 1 as exit code
}

