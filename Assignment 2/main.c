/* main.c	-- Greg Franks Mon May 17 2004
 *
 * $Id: main.c 1908 2012-01-06 17:32:15Z greg $
 */

#ifndef lint
static char *rcsid = "$HeadURL: svn://franks.dnsalias.com/etc/trunk/SYSC-3101/www/yacc-lex/main.c $";
#endif

#include <stdio.h>
#include <stdlib.h>

extern int yyerror();
extern int yylex();

#define YYDEBUG 1

main()
{
/*     yydebug = 1; */
    yyparse();
}
