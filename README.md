# B-- COMPILER
B-- compiler project developed as part of the CS202 course. The B-- compiler is designed to compile B-- programming language code into executable .y(YECC) And .l(LEXAR) file.

### Group Member
>Member 1:Patel Het Rasikkumar
entry no:2021csb1119

>Member 2:Harsh vavadiya
entry no:2021csb1139

### Features
- Lexical analysis and tokenization using a lexer.
- Syntax analysis and parsing using a Bottom-up LALR(1) parser generator.
- Intermediate representation generation.
- Optimization and code generation for the B-- programming language.
- Error handling and reporting.

### Requirements
To run the B-- Compiler, ensure you have the following dependencies installed:
- BMM (Bottom-up LALR(1) Parser Generator)
- C++ Compiler (e.g., GNU g++)

### Installation
1.Clone the repository
2.For testing run CorrectSample.txt by below run part
3.We can see output in lexar.txt file
4.For change file name go line no.180 and 210 and commentout CorrectSample.txt and decomment IncorrectSample.txt  
 
### RUN
For run copy below command and paste in terminal
```
lex BMM_Scanner.l;
yacc -d BMM_Parser.y;
cc lex.yy.c y.tab.c -o BMM;
./BMM;
```
