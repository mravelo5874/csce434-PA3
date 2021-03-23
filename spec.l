%{
    #include <stdio.h>
%}
%%
[0-9]+  { printf("%s\n", yytext); }
.|\n    { /* nothing */ }
%%
main()
{
    yylex();
}