%{

#include <stdio.h>
#include <string.h>
#include <math.h>
#include "y.tab.h"
FILE *lexout,*yyin;

%}
my_digit [0-9]
my_integer [0-9]+

%%
[-]{0,1}{my_integer}"\."{my_integer}                     {fprintf(lexout,"TYPE : numeric constant\n");return NUM_CONST;}     
{my_integer}                                             {fprintf(lexout,"TYPE : int\n");yylval.num=atoi(yytext);return INT;}
(\".*\")                                                {fprintf(lexout,"TYPE : string\n");return STRING;}
"DEF FN"                                               {fprintf (lexout,"DEF STATMENT : %s\n",yytext); return DEFI;}
[A-Z][0-9]?                                            {fprintf(lexout,"ID : %s\n",yytext);return ID;}
[A-Z][0-9]?[$#!%]{0,1}                                  {fprintf(lexout,"ID_TYPE : %s\n",yytext);return ID_TYPE;}
"("                                                    {fprintf(lexout,"LEFT_BRACT : (\n"); return LEFT_BRACT;}
")"                                                   {fprintf (lexout,"RIGHT_BRAC : )\n"); return RIGHT_BRACT;}
"^"                                                     {fprintf (lexout,"EXPONENTIATION : ^\n"); return EXPO;}
"-"                                                     {fprintf (lexout,"MINUS : -\n"); return MINUS;}
[*]                                                     {fprintf (lexout,"MULTIPLY : *\n"); return MULTI;}
"/"                                                     {fprintf (lexout,"DIVISION : /\n"); return DIV;}
"+"                                                     {fprintf (lexout,"PLUS : +\n"); return PLUS;}
"="                                                     {fprintf (lexout,"EQUALITY : =\n"); return EQUAL;}
"<"                                                     {fprintf (lexout,"LESS THAN : <\n"); return LESS;}
">"                                                    {fprintf (lexout,"GREATER THAN : >\n"); return GREATER;}
"<>"                                                    {fprintf (lexout,"NOT EQUAL : <>\n"); return NOT_EQUAL;}
">="                                                    {fprintf (lexout,"GREATER EQUAL : >=\n"); return GREATER_EQUAL;}
"<="                                                    {fprintf (lexout,"LESS EQUAL : <=\n"); return LESS_EQUAL;}
"NOT"                                                   {fprintf (lexout,"NOT : not\n"); return NOT;}
"AND"                                                   {fprintf (lexout,"AND : and\n"); return AND;}
"OR"                                                    {fprintf (lexout,"OR : or\n"); return OR;}
"XOR"                                                   {fprintf (lexout,"XOR : xor\n"); return XOR;}
"DATA"                                                  {fprintf (lexout,"DATA : data\n"); return DATA;}
","                                                     {fprintf (lexout,"COMMA : ,\n"); return COMMA;}  
"DIM"                                                    {fprintf (lexout,"DIM : dim\n"); return DIM;} 
"END"                                                   {fprintf (lexout,"END : end\n"); return END;} 
"FOR"                                                   {fprintf (lexout,"FOR : for\n"); return FOR;}
"TO"                                                    {fprintf (lexout,"TO : to\n"); return TO;}
"STEP"                                                  {fprintf (lexout," STEP : step \n"); return STEP;}
"PRINT"                                                 {fprintf (lexout,"PRINT : print ,\n"); return PRINT;}
"NEXT"                                                  {fprintf (lexout,"NEXT : next\n"); return NEXT;}   
";"                                                     {fprintf (lexout,"SEMICOLON : ; \n"); return SEMICOLON;} 
"GOSUB"                                                 {fprintf (lexout,"GOSUB : gosub \n"); return GOSUB;}
"GOTO"                                                  {fprintf (lexout,"GOTO : goto\n"); return GOTO;}
"IF"                                                    {fprintf (lexout,"IF : if\n"); return IF;} 
"THEN"                                                  {fprintf (lexout,"THEN : then\n"); return THEN;}
"LET"                                                   {fprintf (lexout,"LET : let\n"); return LET;}    
"INPUT"                                                 {fprintf (lexout,"INPUT : input\n"); return INPUT;} 
"RETURN"                                                {fprintf (lexout,"RETURN : return\n"); return RETURN;} 
"STOP"                                                  {fprintf (lexout,"STOP : stop\n"); return STOP;}
REM[^a-z\n]*\n          { fprintf (lexout,"COMMENT : ram\n");
                        unput(yytext[yyleng-1]);
                        return REM;
                      }      
REM[^\n]*\n        {    fprintf (lexout,"COMMENT : ram\n");
                        unput(yytext[yyleng-1]);
                        return REM;
                    }
[ \t]+                                                 
['\n']             {return '\n';}





%%


int yywrap(){
    return 1;

}