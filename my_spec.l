%{
    #include <stdio.h>
    #include <stdlib.h>

    /* TOKEN INTS */
    #define NUM     0
    #define ID      1
    #define LP      2
    #define RP      3
    #define ASGN    4
    #define SC      5
    #define AS      6
    #define POWER   7
    #define MULT    8
    #define ADD     9
    #define COMP    10
    #define IF      11
    #define THEN    12
    #define ELSE    13
    #define BGN     14
    #define ENDIF   15
    #define WHL     16
    #define ENDWHL  17
    #define DO      18
    #define PRGM    19
    #define END     20
    #define VAR     21
    #define INT     22
    #define AND     23
    #define OR      24
    #define NOT     25
    #define READ    26
    #define WRITE   27

    int ln = 1; pos = 0;
    char* str = NULL;
%}
/* BASIC */
ws          [ \t]
digit       [0-9]
num         [1-9][0-9]*|0
cap         [A-Z]
low         [a-z]
letter      {cap}|{low}

/* WORDS */
id          {cap}({cap}|{digit})*
comment     "%"(.)*"\n"

/* SYMBOLS & OPERATORS */
LP          "("
RP          ")"
ASGN        ":="
SC          ";"
AS          ":"
POWER       "**"
MULT        "*"|"div"|"mod"
ADD         "+"|"-"
COMP        "="|"<>"|"<"|">"|"<="|">="

/* KEYWORDS */
IF          "if"
THEN        "then"
ELSE        "else"
BEGIN       "begin"
ENDIF       "endif"
WHILE       "while"
ENDWHILE    "endwhile"
DO          "do"
PROGRAM     "program"
END         "end"
VAR         "var"
INT         "integer"
AND         "and"
OR          "or"
NOT         "not"

/* PROCEDURES */
WRITEINT    "writeInt"
READINT     "readInt"

%%
{ws}+       {   
                /* printf("whitespace len: %i\n", yyleng); */ 
                pos += yyleng;
            }

\n          { 
                ln++;
                pos = 0;
            }

{comment}   {   
                // printf("%d\t%d\t ", ln, pos);  
                // printf("comment: %s", yytext);
                ln++;
                pos = 0;
            }

{num}       {   
                // printf("%d\t%d\t ", ln, pos);  
                // printf("number: %s\n", yytext);
                pos += yyleng;

                str = yytext;
                return(NUM);
            }

{id}        {   
                // printf("%d\t%d\t ", ln, pos);  
                // printf("id: %s\n", yytext); 
                pos += yyleng;

                str = yytext;
                return(ID);
            }

{LP}        {   
                // printf("%d\t%d\t ", ln, pos);
                // printf("LP: %s\n", yytext);
                pos += yyleng;

                str = yytext;
                return(LP);
            }

{RP}        {   
                // printf("%d\t%d\t ", ln, pos);
                // printf("RP: %s\n", yytext);
                pos += yyleng;

                str = yytext;
                return(RP);
            }

{ASGN}      {
                // printf("%d\t%d\t ", ln, pos);
                // printf("ASGN: %s\n", yytext);
                pos += yyleng;
                
                str = yytext;
                return(ASGN);
            }

{SC}        {
                // printf("%d\t%d\t ", ln, pos);
                // printf("SC: %s\n", yytext);
                pos += yyleng;

                str = yytext;
                return(SC);
            }

{AS}        {
                // printf("%d\t%d\t ", ln, pos);
                // printf("AS: %s\n", yytext);
                pos += yyleng;

                str = yytext;
                return(AS);
            }

{POWER}     {
                // printf("%d\t%d\t ", ln, pos);
                // printf("POWER: %s\n", yytext);
                pos += yyleng;

                str = yytext;
                return(POWER);
            }

{MULT}      {
                // printf("%d\t%d\t ", ln, pos);
                // printf("MULT: %s\n", yytext);
                pos += yyleng;

                str = yytext;
                return(MULT);
            }

{ADD}       {
                // printf("%d\t%d\t ", ln, pos);
                // printf("ADD: %s\n", yytext);
                pos += yyleng;

                str = yytext;
                return(ADD);
            }

{COMP}      {
                // printf("%d\t%d\t ", ln, pos);
                // printf("COMP: %s\n", yytext);
                pos += yyleng;

                str = yytext;
                return(COMP);
            }

{IF}        {
                // printf("%d\t%d\t ", ln, pos);
                // printf("IF: %s\n", yytext);
                pos += yyleng;

                str = yytext;
                return(IF);
            }

{THEN}      {
                // printf("%d\t%d\t ", ln, pos);
                // printf("THEN: %s\n", yytext);
                pos += yyleng;

                str = yytext;
                return(THEN);
            }

{ELSE}      {
                // printf("%d\t%d\t ", ln, pos);
                // printf("ELSE: %s\n", yytext);
                pos += yyleng;

                str = yytext;
                return(ELSE);
            }

{BEGIN}     {
                // printf("%d\t%d\t ", ln, pos);
                // printf("BEGIN: %s\n", yytext);
                pos += yyleng;

                str = yytext;
                return(BGN);
            }

{ENDIF}     {
                // printf("%d\t%d\t ", ln, pos);
                // printf("ENDIF: %s\n", yytext);
                pos += yyleng;

                str = yytext;
                return(ENDIF);
            }

{WHILE}     {
                // printf("%d\t%d\t ", ln, pos);
                // printf("WHILE: %s\n", yytext);
                pos += yyleng;

                str = yytext;
                return(WHL);
            }

{ENDWHILE}  {
                // printf("%d\t%d\t ", ln, pos);
                // printf("ENDWHILE: %s\n", yytext);
                pos += yyleng;

                str = yytext;
                return(ENDWHL);
            }

{DO}        {
                // printf("%d\t%d\t ", ln, pos);
                // printf("DO: %s\n", yytext);
                pos += yyleng;

                str = yytext;
                return(DO);
            }

{PROGRAM}   {
                // printf("%d\t%d\t ", ln, pos);
                // printf("PROGRAM: %s\n", yytext);
                pos += yyleng;

                str = yytext;
                return(PRGM);
            }

{END}       {
                // printf("%d\t%d\t ", ln, pos);
                // printf("END: %s\n", yytext);
                pos += yyleng;

                str = yytext;
                return(END);
            }

{VAR}       {
                // printf("%d\t%d\t ", ln, pos);
                // printf("VAR: %s\n", yytext);
                pos += yyleng;

                str = yytext;
                return(VAR);
            }
        
{INT}       {
                // printf("%d\t%d\t ", ln, pos);
                // printf("INT: %s\n", yytext);
                pos += yyleng;

                str = yytext;
                return(INT);
            }

{AND}       {
                // printf("%d\t%d\t ", ln, pos);
                // printf("AND: %s\n", yytext);
                pos += yyleng;

                str = yytext;
                return(AND);
            }

{OR}        {
                // printf("%d\t%d\t ", ln, pos);
                // printf("OR: %s\n", yytext);
                pos += yyleng;

                str = yytext;
                return(OR);
            }
        
{NOT}       {
                // printf("%d\t%d\t ", ln, pos);
                // printf("NOT: %s\n", yytext);
                pos += yyleng;

                str = yytext;
                return(NOT);
            }
        
{WRITEINT}  {
                // printf("%d\t%d\t ", ln, pos);
                // printf("WRITEINT: %s\n", yytext);
                pos += yyleng;

                str = yytext;
                return(WRITE);
            }

{READINT}   {
                // printf("%d\t%d\t ", ln, pos);
                // printf("READINT: %s\n", yytext);
                pos += yyleng;

                str = yytext;
                return(READ);
            }
%%
main(int argc, char* argv[])
{
    if (argc > 1)
    {
        FILE *fp = fopen(argv[1], "r");
        if (fp) yyin = fp;
    }

    int value = 0;
    while (value != END)
    {
        value = yylex();
        printf("ln:%d\tpos:%d\t ", ln, pos);
        printf("symbl:%d\tstr:%s\n", value, str);
    }

    return 1;
}