%{
    #include <stdio.h>
%}
digit       [0-9]
letter      [A-Za-z]
id          {letter}({letter}|{digit})*
%%
{digit}+    { printf("number: %s\n", yytext); }
{id}        { printf("id: %s\n", yytext); }
.           { printf("other: %s\n", yytext); }
%%
main()
{
    yylex();
}