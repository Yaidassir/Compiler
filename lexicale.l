%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include "syntaxique.tab.h"
#include "TableS.h"
#include "quadruple.h"
int yylineo=1;
int nbcol=1;
int in;
%}
IDF [A-Z](_|[a-z]|[0-9]){0,7}
INT ("("[+-][0-2]?[0-9]?[0-9]?[0-9]?[0-9]?")")|("("[+-][3]?[2]?[0-7]?[0-6]?[0-8]?")")|[1-9][0-9]*|("("[3]?[2]?[0-7]?[0-6]?[0-8]?")")|("("[0-2]?[0-9]?[0-9]?[0-9]?[0-9]?")")|0
FLOAT ("("[+-]([0-2]?[0-9]?[0-9]?[0-9]?[0-9]?)"."(([0-9]*)[1-9]|0)")")|("("[+-]([3]?[2]?[0-7]?[0-6]?[0-8]?)"."(([0-9]*)[1-9]|0)")")|([1-9]([0-9]*))"."(([0-9]*)[1-9]|0)|("("([3]?[2]?[0-7]?[0-6]?[0-8]?)"."(([0-9]*)[1-9]|0)")")|("("([0-2]?[0-9]?[0-9]?[0-9]?[0-9]?)"."(([0-9]*)[1-9]|0)")")|0"."(([0-9]*)[1-9]|0)
STRING (\")(.*)+(\")
CHAR '[A-Za-z0-9]'
espace [ \t]
SAUT_LIGNE [\n]
COMMENTAIRE "//"[^\n]*|(.)*[^\n]*((.)*|(_))"//"
error [^ \n\t]
%%
PROGRAM {   
	rechercher(yytext,"mot cle","","","",2);  
	  nbcol = nbcol + strlen(yytext);
	      return mc_program;}
END {   
    rechercher(yytext,"mot cle","","","",2);
        nbcol = nbcol + strlen(yytext);
            return mc_end;}
BEGIN {     rechercher(yytext,"mot cle","","","",2); 
   nbcol = nbcol + strlen(yytext); 
      return mc_begin;}
var {       rechercher(yytext,"mot cle","","","",2);
    nbcol = nbcol + strlen(yytext); 
       return mc_var;}
INT {       rechercher(yytext,"mot cle","","","",2); 
   nbcol = nbcol + strlen(yytext);
       return mc_int;}
CHAR {      rechercher(yytext,"mot cle","","","",2);  
  nbcol = nbcol + strlen(yytext); 
     return mc_char;}
FLOAT {     rechercher(yytext,"mot cle","","","",2); 
   nbcol = nbcol + strlen(yytext);
       return mc_float;}
GET {       rechercher(yytext,"mot cle","","","",2); 
   nbcol = nbcol + strlen(yytext);  
     return mc_get;}
[lL]et {    rechercher(yytext,"mot cle","","","",2); 
   nbcol = nbcol + strlen(yytext);  
     return mc_let;}
STRING {    rechercher(yytext,"mot cle","","","",2);  
  nbcol = nbcol + strlen(yytext); 
     return mc_string;}
SHOW {      rechercher(yytext,"mot cle","","","",2);
    nbcol = nbcol + strlen(yytext); 
       return mc_show;}
FOR {       rechercher(yytext,"mot cle","","","",2); 
   nbcol = nbcol + strlen(yytext); 
      return mc_for;}
END_FOR {   rechercher(yytext,"mot cle","","","",2);
    nbcol = nbcol + strlen(yytext);  
      return mc_endfor;}
IF {        rechercher(yytext,"mot cle","","","",2); 
   nbcol = nbcol + strlen(yytext); 
      return mc_if;}
ELSE {      rechercher(yytext,"mot cle","","","",2); 
   nbcol = nbcol + strlen(yytext);    return mc_else;}
RETURN {   
 rechercher(yytext,"mot cle","","","",2);  
   nbcol = nbcol + strlen(yytext);    return mc_return;}
ENDIF {    
 rechercher(yytext,"mot cle","","","",2); 
    nbcol = nbcol + strlen(yytext);    return mc_endif;}
{IDF} {   
  rechercher(yytext,"IDF","","","",0);   
       nbcol = nbcol + strlen(yytext);  
         return idf;}
{STRING} {  rechercher(yytext,"STRING","","","",0); 
    nbcol = nbcol + strlen(yytext);    return string;}
{CHAR} {    rechercher(yytext,"CHAR","","","",0);   
    nbcol = nbcol + strlen(yytext);    return chr;}
"==" {  rechercher(yytext,"OP LOGIC","","","",1);nbcol = nbcol + strlen(yytext);    return egal;}
"+" {  rechercher(yytext,"OP ARITHM","","","",1);nbcol = nbcol + strlen(yytext);    return op_plus;}
"*" {  rechercher(yytext,"OP ARITHM","","","",1);nbcol = nbcol + strlen(yytext);    return op_mul;}
"-" {  rechercher(yytext,"OP ARITHM","","","",1);nbcol = nbcol + strlen(yytext);    return op_moin;}
"/" {  rechercher(yytext,"OP ARITHM","","","",1);nbcol = nbcol + strlen(yytext);    return op_div;}
">>" {  rechercher(yytext,"OP LOGIC","","","",1);nbcol = nbcol + strlen(yytext);    return sup;}
"<<" {  rechercher(yytext,"OP LOGIC","","","",1);nbcol = nbcol + strlen(yytext);    return inf;}
"<<>>" {  rechercher(yytext,"OP LOGIC","","","",1);nbcol = nbcol + strlen(yytext);    return diff;}
">>=" {  rechercher(yytext,"OP LOGIC","","","",1);nbcol = nbcol + strlen(yytext);    return sup_ou_eg;}
"<<=" {  rechercher(yytext,"OP LOGIC","","","",1);nbcol = nbcol + strlen(yytext);    return inf_ou_eg;}
":" {     rechercher(yytext,"Sep","","","",1);nbcol = nbcol + strlen(yytext);    return sep_dp;}
"£" {     rechercher(yytext,"Sep end instr","","","",1);nbcol = nbcol + strlen(yytext);    return sep_ls;}
"(" {     rechercher(yytext,"Sep","","","",1);nbcol = nbcol + strlen(yytext);    return sep_povr;}
")" {     rechercher(yytext,"Sep","","","",1);nbcol = nbcol + strlen(yytext);    return sep_pfrm;}
"[" {     rechercher(yytext,"Sep","","","",1);nbcol = nbcol + strlen(yytext);    return sep_covr;}
"]" {     rechercher(yytext,"Sep","","","",1);nbcol = nbcol + strlen(yytext);    return sep_cfrm;}
"{" {     rechercher(yytext,"Sep","","","",1);nbcol = nbcol + strlen(yytext);    return sep_acovr;}
"}" {     rechercher(yytext,"Sep","","","",1);nbcol = nbcol + strlen(yytext);    return sep_acfrm;}
"||" {     rechercher(yytext,"Sep","","","",1);nbcol = nbcol + strlen(yytext);    return sep;}
"@" {     rechercher(yytext,"Signe","","","",1);nbcol = nbcol + strlen(yytext);    return sep_arob;}
"&" {     rechercher(yytext,"Signe","","","",1);nbcol = nbcol + strlen(yytext);    return sep_etcom;}
\" {     rechercher(yytext,"Sep","","","",1);nbcol = nbcol + strlen(yytext);    return sep_gui;}
"#" {     rechercher(yytext,"Signe","","","",1);nbcol = nbcol + strlen(yytext);    return sep_hash;}
"%" {     rechercher(yytext,"Signe","","","",1);nbcol = nbcol + strlen(yytext);    return sep_prc;}
"$" {     rechercher(yytext,"Signe","","","",1);nbcol = nbcol + strlen(yytext);    return sep_doll;}
"=" {       rechercher(yytext,"Affectation","","","",1);nbcol = nbcol + strlen(yytext);    return sep_eg;}
{INT} {in=atoi(yytext);if(in>=-32768 && in<=32767){rechercher (yytext,"INTEGER","","","",0);} else{printf("\n Erreur lexical: yylineo: %d Entité << %s >> non reconnu par le langage \n",yylineo,yytext);} nbcol = nbcol + strlen(yytext); return ent;}
{FLOAT} {   rechercher (yytext,"FLOAT","","","",0); nbcol = nbcol + strlen(yytext);     return floaat;}
{COMMENTAIRE} {nbcol = nbcol + strlen(yytext);}
{espace} {nbcol = nbcol + strlen(yytext);} 
{SAUT_LIGNE} {yylineo++;    nbcol=1;}
error { printf("\n Erreur lexical: yylineo: %d; Collone: %d; Entité << %s >> non reconnu par le langage \n",yylineo, nbcol, yytext); nbcol = nbcol + strlen(yytext);}
%%
int yywrap(){
 return 1;
}

