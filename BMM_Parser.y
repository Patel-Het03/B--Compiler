%{

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include <ctype.h>
int line_no[9999];
int Gosub_Count=0;
int count_max=0;
int yylex();
void yyerror(char const *);
extern FILE *yyin,*yyout,*lexout;

%}
%token INT  STRING ID  
      LEFT_BRACT RIGHT_BRACT EXPO 
       MINUS MULTI DIV PLUS 
       EQUAL LESS GREATER NOT_EQUAL 
       GREATER_EQUAL LESS_EQUAL NOT AND 
       OR XOR DATA DEFI 
       COMMA DIM END FOR 
       TO STEP SEMICOLON GOSUB 
       GOTO IF THEN LET 
       INPUT REM RETURN STOP 
       NUM_CONST PRINT NEXT
       ID_TYPE 

%union{
    int num;
}

%%
  program:statement;

  statement:stmt '\n'
           |statement stmt '\n';

  stmt:INT DATA dt                                                  
      |INT ID                                                        
      |INT DEFI ID EQUAL expression                                     
      |INT DEFI ID expression EQUAL expression                         
      |INT DIM di                                                       
      |INT END{
                  if(count_max!=yylval.num){
                    printf("ERROR:-END IS NOT AT LAST");
                  }
                }
      |INT FOR ID EQUAL expression TO expression STEP expression '\n'       
            statement INT NEXT ID
      |INT FOR ID EQUAL expression TO expression '\n'
            statement INT NEXT ID
      |NEXT ID                                                         
      |INT PRINT follow_print                                          
      |INT GOSUB INT   {
                         Gosub_Count++;
                        }
      |INT GOTO INT   {
                            if(line_no[yylval.num]==0){
                                printf("ERROR:- GOTO LINE NUMBER IS NOT CORRECT\n");
                            }
                      }
      |INT IF bool THEN INT                                                             
      |INT LET ID_TYPE EQUAL expression                             
      |INT LET ID EQUAL expression                                  
      |INT LET ID LEFT_BRACT temp COMMA temp RIGHT_BRACT EQUAL expression 
      |INT INPUT follow_input                                         
      |INT RETURN{
                  if(Gosub_Count==0){
                    printf("ERROR:-GOSUB NOT EXITS");
                  }
                  else{
                    Gosub_Count--;
                  }
                 }

      |INT STOP                                                     
      |INT REM                                                      
    
      ;

  

    expression:expr1
              |expression PLUS expr1          {fprintf(yyout,"Operator : + \n");}
              |expression MINUS expr1          {fprintf(yyout,"Operator : - \n");}
              ;        

    expr1:expr2
         |expr1 MULTI expr2                    {fprintf(yyout,"Operator : * \n");}
         |expr1 DIV expr2                       {fprintf(yyout,"Operator : / \n");}
         ;                      

    expr2:expr3
         |MINUS expr2                           {fprintf(yyout,"Operator : negation \n");}
         ;

    expr3:expr4
          |expr3 EXPO expr4                     {fprintf(yyout,"Operator : ^ \n");}
          ;

    expr4:NUM_CONST
         |INT
         |STRING
         |ID
         |ID_TYPE
         |LEFT_BRACT expression RIGHT_BRACT
         |ID LEFT_BRACT expression RIGHT_BRACT
         ;
         
   

         
    bool:expression EQUAL expression        {fprintf(yyout,"Operator : = \n");}
        |expression NOT_EQUAL expression    {fprintf(yyout,"Operator : <> \n");}
        |expression LESS expression         {fprintf(yyout,"Operator : < \n");}
        |expression GREATER expression       {fprintf(yyout,"Operator : > \n");}
        |expression LESS_EQUAL expression    {fprintf(yyout,"Operator : <= \n");}
        |expression GREATER_EQUAL expression  {fprintf(yyout,"Operator : >= \n");}
        |bool AND bool
        | NOT expression
        |bool OR bool
        |expression
        ;

        


   temp1:INT
        |NUM_CONST
        |STRING;

   dt: temp1 
       |temp1 COMMA dt
       ;

   di: ID LEFT_BRACT INT RIGHT_BRACT
       |ID LEFT_BRACT INT COMMA INT RIGHT_BRACT
       |ID LEFT_BRACT INT RIGHT_BRACT COMMA di
       |ID LEFT_BRACT INT COMMA INT RIGHT_BRACT COMMA di;

   follow_print:expression
               |expression COMMA follow_print
               |expression SEMICOLON follow_print
               |SEMICOLON
               |COMMA
               |
               ;
    temp:ID
        |ID_TYPE
        |INT;

    follow_input:ID
                |ID_TYPE
                |ID LEFT_BRACT temp RIGHT_BRACT
                |ID LEFT_BRACT temp COMMA temp RIGHT_BRACT
                |ID COMMA follow_input
                |ID_TYPE COMMA follow_input
                |ID LEFT_BRACT temp RIGHT_BRACT COMMA follow_input
                |ID ID LEFT_BRACT temp COMMA temp RIGHT_BRACT COMMA follow_input
                ;
   

    
           




%%
int main(){
      FILE *filepointer;
    char buffer[1024];
    int current_line_num = 0;

    for(int i=0;i<9999;i++){
        line_no[i]=0;
    }

    filepointer = fopen("CorrectSample.txt", "r");  // open the file for reading
    // filepointer = fopen("IncorrectSample.txt", "r"); 
    if (filepointer == NULL) {
        printf("Error: Unable to open file\n");
        return 1;
    }
    while (fgets(buffer, 1024, filepointer)) {
        
        int line_num = atoi(buffer);
        line_no[line_num]++;
        if(line_num>count_max){
            count_max=line_num;
        }
        if (line_num < 1 || line_num > 9999) {
            printf("Error: Invalid line number\n");
            return 1;
        }
        if (line_num <= current_line_num) {
            printf("Error: Lines are not in ascending order\n");
            return 1;
        }
        current_line_num = line_num;
        printf("%s\n", buffer);
    }

   
    fclose(filepointer);
    
    

    yyin=fopen("CorrectSample.txt","r");
    // yyin=fopen("IncorrectSample.txt","r");
    lexout=fopen("lexar.txt","w");
    yyout=fopen("parser.txt","w");
    yyparse();
    return 0;
}
void yyerror(char const *s){
    printf("Syntax Error\n");
}
