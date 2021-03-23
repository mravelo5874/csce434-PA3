%{
    #include <stdio.h>
    int ch=0, wd=0, nl=0;
%}
delim       [ \t]+
%%
\n          { ch++; wd++; nl++; }
^{delim}    { ch+=yyleng; }
{delim}     { ch+=yyleng; wd++; }
.           { ch++; }
%%
main()
{
    yylex();
    printf("%8d %8d %8d\n", nl, wd, ch);
}