%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <stdbool.h>

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

    #define INVALID 99

    int ln = 1; 
    int pos = 0;
    char* str = NULL;
    int currentToken = 0;
    bool printTree = true;
%}
/* BASIC */
ws          [ \t]
digit       [0-9]
num         [-]?[1-9][0-9]*|0
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
                ln++;
                pos = 0;
            }

{num}       {   
                pos += yyleng;
                str = yytext;
                return(NUM);
            }

{id}        {   
                pos += yyleng;
                str = yytext;
                return(ID);
            }

{LP}        {   
                pos += yyleng;
                str = yytext;
                return(LP);
            }

{RP}        {   
                pos += yyleng;
                str = yytext;
                return(RP);
            }

{ASGN}      {
                pos += yyleng;
                str = yytext;
                return(ASGN);
            }

{SC}        {
                pos += yyleng;
                str = yytext;
                return(SC);
            }

{AS}        {
                pos += yyleng;
                str = yytext;
                return(AS);
            }

{POWER}     {
                pos += yyleng;
                str = yytext;
                return(POWER);
            }

{MULT}      {
                pos += yyleng;
                str = yytext;
                return(MULT);
            }

{ADD}       {
                pos += yyleng;
                str = yytext;
                return(ADD);
            }

{COMP}      {              
                pos += yyleng;
                str = yytext;
                return(COMP);
            }

{IF}        {
                pos += yyleng;
                str = yytext;
                return(IF);
            }

{THEN}      {
                pos += yyleng;
                str = yytext;
                return(THEN);
            }

{ELSE}      {
                pos += yyleng;
                str = yytext;
                return(ELSE);
            }

{BEGIN}     {
                pos += yyleng;
                str = yytext;
                return(BGN);
            }

{ENDIF}     {
                pos += yyleng;
                str = yytext;
                return(ENDIF);
            }

{WHILE}     {
                pos += yyleng;
                str = yytext;
                return(WHL);
            }

{ENDWHILE}  {
                pos += yyleng;
                str = yytext;
                return(ENDWHL);
            }

{DO}        {
                pos += yyleng;
                str = yytext;
                return(DO);
            }

{PROGRAM}   {
                pos += yyleng;
                str = yytext;
                return(PRGM);
            }

{END}       {
                pos += yyleng;
                str = yytext;
                return(END);
            }

{VAR}       {
                pos += yyleng;
                str = yytext;
                return(VAR);
            }
        
{INT}       {
                pos += yyleng;
                str = yytext;
                return(INT);
            }

{AND}       {
                pos += yyleng;
                str = yytext;
                return(AND);
            }

{OR}        {
                pos += yyleng;
                str = yytext;
                return(OR);
            }
        
{NOT}       {
                pos += yyleng;
                str = yytext;
                return(NOT);
            }
        
{WRITEINT}  {
                pos += yyleng;
                str = yytext;
                return(WRITE);
            }

{READINT}   {
                pos += yyleng;
                str = yytext;
                return(READ);
            }

.           {
                pos += yyleng;
                str = yytext;
                return(INVALID);
            } 
%%

/* BNF GRAMMAR */

// <program>            ::= PROGRAM <declarations> BEGIN <statementSequence> END
// -------------------------------------------------------------------------------------
// <declarations>       ::= VAR ident AS <type> SC <declarations>
//                        | ε
// -------------------------------------------------------------------------------------
// <type>               ::= INT 
// -------------------------------------------------------------------------------------
// <statementSequence>  ::= <statement> SC <statementSequence>
//                        | ε
// -------------------------------------------------------------------------------------
// <statement>          ::= <assignment>
//                        | <ifStatement>
//                        | <whileStatement>
//                        | <writeInt>
//                        | ε
// -------------------------------------------------------------------------------------
// <assignment>         ::= ident ASGN <expression>
//                        | ident ASGN READINT
// -------------------------------------------------------------------------------------
// <ifStatement>        ::= IF <expression> THEN <statementSequence> <elseClause> ENDIF
// -------------------------------------------------------------------------------------
// <elseClause>         ::= ELSE <statementSequence>
//                        | ε
// -------------------------------------------------------------------------------------
// <whileStatement>     ::= WHILE <expression> DO <statementSequence> ENDWHILE
// -------------------------------------------------------------------------------------
// <writeInt>           ::= WRITEINT <expression>
// -------------------------------------------------------------------------------------
// <expression>         ::= <simpleExpression>
//                        | <simpleExpression> COMPARE <expression>
// -------------------------------------------------------------------------------------
// <simpleExpression>   ::= <term> ADDITIVE <simpleExpression>
//                        | term OR <simpleexpression>
//                        |<term>
// -------------------------------------------------------------------------------------
// <term>               ::= <factor> MULTIPLICATIVE <term>
//                        | <factor> AND <term> 
//                        | <factor>
// -------------------------------------------------------------------------------------
// <factor>             ::= <primary> POWER<factor> 
//                        | <primary>
// -------------------------------------------------------------------------------------
// <primary>            ::= ident
//                        | num
//                        | LP <expression> RP
//                        | “-“ <primary>
//                        | NOT <primary>

/* UTIL FUNCTIONS */
void printError(char* type, char* msg)
{
    printf("[%s] %s at line %d pos %d\n", type, msg, ln, pos);
    exit(-1);
}

void printSyntaxTree(char* func, bool start)
{
    if (!printTree) return;

    if (start)
    {
        printf("*starting %s\n", func);
    }
    else
    {
        printf("*ending %s\n", func);
    }
}

void validateToken(int token, char* str_token)
{
    if (currentToken != token)
    {
        char msg[128] = "expected \'";
        strcat(msg, str_token);
        strcat(msg, "\' token but found \'");
        strcat(msg, str);
        strcat(msg, "\'");

        printError("SYNTAX ERROR", msg);
    }

    // printf("val token: ");
    // printf("%s\n", str_token);
}

char* getTokenStr(int n)
{
    switch(n)
    {
        default:
        case NUM:
            return "NUM";
        case ID:
            return "ID";
        case LP:
            return "LP";
        case RP:
            return "RP";
        case ASGN:
            return "ASGN";
        case SC:
            return "SC";
        case AS:
            return "AS";
        case POWER:
            return "POWER";
        case MULT:
            return "MULT";
        case ADD:
            return "ADD";
        case COMP:
            return "COMP";
        case IF:
            return "IF";
        case THEN:
            return "THEN";
        case ELSE:
            return "ELSE";
        case BGN:
            return "BEGIN";
        case ENDIF:
            return "ENDIF";
        case WHL:
            return "WHILE";
        case ENDWHL:
            return "ENDWHILE";
        case DO:
            return "DO";
        case PRGM:
            return "PROGRAM";
        case END:
            return "END";
        case VAR:
            return "VAR";
        case INT:
            return "INT";
        case AND:
            return "AND";
        case OR:
            return "OR";
        case NOT:
            return "NOT";
        case READ:
            return "READINT";
        case WRITE:
            return "WRITEINT";
        case INVALID:
            return "INVALID";
    }
}

void getNextToken()
{
    currentToken = yylex();

    printf("new curr token: ");
    printf("%s\n", getTokenStr(currentToken));
}

char* getID()
{
    validateToken(ID, "id");
    return str;
}

int getInt()
{
    validateToken(INT, "integer");
    return atoi(str);
}

/* GRAMMAR FUNCTIONS */

// predeclared functions
void statementSequence(void);
void ifStatement(void);
void expression(void);



void primary()
{
    printSyntaxTree("primary()", true);

    // can be ID, NUM, LP EXPR RP, "-" PRIMARY, or NOT PRIMARY
    getNextToken();

    if (currentToken == ID)
    {
        validateToken(ID, "id");
        char* id = str;
    }
    else if (currentToken == NUM)
    {
        validateToken(NUM, "num");
        char* num = str;

    }
    else if (currentToken == LP)
    {
        validateToken(LP, "(");
        
        // expression
        expression();

        getNextToken();
        validateToken(RP, ")");
    }
    else if (currentToken == NOT)
    {
        validateToken(NOT, "not");

        // primary
        primary();
    }
    else
    {
        // send error?
        printError("SYNTAX", "invalid token");
    }

    printSyntaxTree("term()", false);
}

void factor()
{
    printSyntaxTree("factor()", true);

    // primary
    primary();

    // determine if next token is POWER
    getNextToken();
    if (currentToken == POWER)
    {
        validateToken(POWER, "**");
    }
    else
    {
        printSyntaxTree("factor()", false);
        return;
    }

    // factor
    factor();

    printSyntaxTree("factor()", false);
}

void term()
{
    printSyntaxTree("term()", true);

    // factor
    factor();

    // determine if next token is MULT or AND
    getNextToken();
    if (currentToken == MULT)
    {
        validateToken(MULT, "mult");
    }
    else if (currentToken == AND)
    {
        validateToken(AND, "and");
    }
    else
    {
        printSyntaxTree("term()", false);
        return;
    }

    // term
    term();

    printSyntaxTree("term()", false);
}

void simpleExpression()
{
    printSyntaxTree("simpleExpression()", true);

    // term
    term();

    // determine if next token is ADD or OR
    getNextToken();
    if (currentToken == ADD)
    {
        validateToken(ADD, "add");
    }
    else if (currentToken == OR)
    {
        validateToken(OR, "or");
    }
    else 
    {
        printSyntaxTree("simpleExpression()", false);
        return;
    }

    // simpleExpression
    simpleExpression();

    printSyntaxTree("simpleExpression()", false);
}

void expression()
{
    printSyntaxTree("expression()", true);

    // simpleExpression
    simpleExpression();

    // determine if next token is COMP
    getNextToken();
    if (currentToken == COMP)
    {
        // COMP
        validateToken(COMP, "comp");

        // expression
        expression();
    }

    printSyntaxTree("expression()", false);
}

void writeInt()
{
    printSyntaxTree("writeInt()", true);

    // WRITEINT
    validateToken(WRITE, "writeInt");

    // expression
    expression();

    printSyntaxTree("writeInt()", false);
}

void whileStatement()
{
    printSyntaxTree("whileStatement()", true);

    // WHILE
    validateToken(WHL, "while");

    // expression
    expression();

    // DO
    getNextToken();
    validateToken(DO, "do");

    // statementSequence
    getNextToken();
    statementSequence();

    // ENDWHILE
    getNextToken();
    validateToken(ENDWHL, "endwhile");

    printSyntaxTree("whileStatement()", false);
}

void elseClause()
{
    printSyntaxTree("elseClause()", true);

    getNextToken();
    if (currentToken == ELSE)
    {
        validateToken(ELSE, "else");
        
        // statementSequence
        statementSequence();
    }

    printSyntaxTree("elseClause()", false);
}

void ifStatement()
{
    printSyntaxTree("ifStatement()", true);

    // IF
    validateToken(IF, "if");

    // expression
    expression();

    // THEN
    getNextToken();
    validateToken(THEN, "then");

    // statementSequence
    getNextToken();
    statementSequence();

    // elseClause
    elseClause();

    // ENDIF
    validateToken(ENDIF, "endif");

    printSyntaxTree("ifStatement()", false);
}

void assignment()
{
    printSyntaxTree("assignment()", true);

    // ID
    char* id = getID();

    // ASGN
    getNextToken();
    validateToken(ASGN, ":=");

    getNextToken();
    // determine btwn expression or readInt
    if (currentToken == READ)
    {
        // READINT
    }
    else
    {
        expression();
    }

    printSyntaxTree("assignment()", false);
}

void statement()
{
    printSyntaxTree("statement()", true);

    if (currentToken == ID)
    {
        assignment();
    }
    else if (currentToken == IF)
    {
        ifStatement();
    }
    else if (currentToken == WHL)
    {
        whileStatement();
    }
    else if (currentToken == WRITE)
    {
        writeInt();
    }
    
    printSyntaxTree("statement()", false);
}

void statementSequence()
{
    printSyntaxTree("statementSequence()", true);

    getNextToken();
    // return if next token is not
    // ID, IF, WHILE, or WRITEINT
    if (currentToken != ID &&
        currentToken != IF &&
        currentToken != WHL &&
        currentToken != WRITE)
    {
        printSyntaxTree("statementSequence()", false);
        return;
    }

    // statement
    statement();

    // SC
    getNextToken();
    validateToken(SC, ";");

    statementSequence();

    printSyntaxTree("statementSequence()", false);
}

void declarations()
{
    printSyntaxTree("declarations()", true);

    // VAR
    getNextToken();
    // return if next token is not VAR
    if (currentToken != VAR)
    {
        printSyntaxTree("declarations()", false);
        return;
    }
    validateToken(VAR, "var");

    // ID
    getNextToken();
    char* id = getID();
    
    // AS
    getNextToken();
    validateToken(AS, ":");

    // INT
    getNextToken();
    int num = getInt();

    // SC
    getNextToken();
    validateToken(SC, ";");

    // more declarations
    declarations();

    printSyntaxTree("declarations()", false);
}

void program()
{
    printf("starting lexical analysis...\n");
    printSyntaxTree("program()", true);

    // PRGM
    getNextToken();
    validateToken(PRGM, "program");

    // declarations
    declarations();

    // BEGIN
    validateToken(BGN, "begin");

    // statementSequence
    statementSequence();

    validateToken(END, "end");
    
    printSyntaxTree("program()", false);
    printf("lexical analysis complete...\n");
}


int main(int argc, char* argv[])
{
    if (argc > 1)
    {
        FILE *fp = fopen(argv[1], "r");
        if (fp) yyin = fp;
    }

    program();

    // int value = 0;
    // while (value != END)
    // {
    //     value = yylex();
    //     printf("ln:%d\tpos:%d\t ", ln, pos);
    //     printf("symbl:%d\tstr:%s\n", value, str);
    // }

    return 1;
}