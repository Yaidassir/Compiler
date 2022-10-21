%{
#include<stdio.h>
#include<stdlib.h>
extern FILE* yyin ;
extern int yylineo;
extern int nbcol;
int qc=0;
int fin_if,deb_else,val,num_quand;
char temp[10];
int yylex();
int yyerror();
void affich();
%}
%union{
int integer;
char* string;
float reel;
}
%token mc_program mc_end mc_begin mc_var <string>mc_int <string>mc_float <string>mc_char <string>mc_string mc_let mc_get mc_show mc_if mc_else mc_return mc_endif mc_for mc_endfor 
%token <string>idf <string>string <string>chr <reel>floaat <integer>ent
%token sep_ls sep_dp sep_povr sep_pfrm sep_acovr sep_acfrm sep sep_arob sep_covr sep_cfrm sep_etcom sep_hash sep_prc sep_doll  sep_gui sep_eg
%token inf sup diff inf_ou_eg sup_ou_eg egal op_div op_mul op_moin op_plus 
%left  inf sup diff inf_ou_eg sup_ou_eg egal
%left  op_moin  op_plus 
%left  op_div   op_mul
%type <string> tab affect GET SHOW op operation
%start project
%%
project : entete declaration mc_begin inst mc_end {printf ("programme correct\n");}
;
entete : mc_program idf 
;
declaration : mc_var multi_var sep_dp type sep_ls declaration
            | mc_var multi_tab sep_dp sep_covr type sep_cfrm sep_ls declaration 
            | mc_let multi_const type sep_eg val sep_ls declaration 
            | mc_let multi_const sep_eg val sep_ls declaration
            |
;
multi_tab : idf sep_covr ent sep_cfrm multi_tab {  
                                                if (doubleDeclaration($1)==0)
                                                    { 
                                                        char var[20];
                                                        sprintf(var,"%d",$3); 
                                                        RemplaceTaille($1,var);
                                                        insertType($1,"type select");  
                                                    }
                                                else
                                                    {
                                                        printf("erreur semantique a la yylineo %d , Double declaration du tableau %s\n",yylineo,$1);
                                                    }
                                            }
            | idf sep_covr ent sep_cfrm {
                                if (doubleDeclaration($1)==0)
                                    {
                                        char var[20];
                                        sprintf(var,"%d",$3); 
                                        RemplaceTaille($1,var);
                                        insertType($1,"type select");
                                    }
                                else
                                    {
                                        printf("erreur semantique a la yylineo %d , Double declaration du tableau %s\n",yylineo,$1);
                                    }  
                            }
;
multi_var : idf sep multi_var {
                                if (doubleDeclaration($1)==0)
                                    {
                                        insertType($1,"type select");  
                                    }
                                else
                                    {
                                        printf("erreur semantique a la yylineo %d , Double declaration de la variable %s\n",yylineo,$1);
                                    }
                              }
          | idf {
                    if (doubleDeclaration($1)==0)
                        {
                            insertType($1,"type select");  
                        }
                    else
                        {
                            printf("erreur semantique a la yylineo %d , Double declaration de la variable %s\n",yylineo,$1);
                        }
                }
;
multi_const : idf sep multi_var {
                                        if (doubleDeclaration($1)==0)
                                            {
                                                modifierConst($1);
                                                insertType($1,"type select");                                                   
                                            }
                                        else
                                            {
                                                printf("erreur semantique a la yylineo %d , Double declaration de la constante %s\n",yylineo,$1);
                                            }
                                    }               
          | idf {  
                    if (doubleDeclaration($1)==0)
                        { 
                            modifierConst($1);
                            insertType($1,"type select");  
                        }
                    else
                        {
                            printf("erreur semantique a la yylineo %d , Double declaration de la constante %s\n",yylineo,$1);
                        }
                }
;

type : mc_int {insererTYPE($1);}
     | mc_float {insererTYPE($1);}
     | mc_char {insererTYPE($1);}
     | mc_string {insererTYPE($1);}
;
val : floaat
    | ent 
    | chr 
    | string
;
tab :  idf sep_covr ent sep_cfrm {
                                    if (variableDejaDeclarer($1)==1)
                                        {
                                            printf("Erreur Semantique a la ligne %d , la variable %s est non declarer\n",yylineo, $1);
                                        }
                                    }
     | idf sep_covr idf sep_cfrm {
                                    if (variableDejaDeclarer($1)==1)
                                        {
                                            printf("Erreur Semantique a la ligne %d , la variable %s est non declarer\n",yylineo, $1);
                                        }else{
                                          if (variableDejaDeclarer($3)==1)
                                        {
                                            printf("Erreur Semantique a la ligne %d , la variable %s est non declarer\n",yylineo, $3);
                                        }
                                        }
                                    }
;
inst : affect sep_ls inst
     | FOR inst 
     | GET inst 
     | SHOW inst
     | IF inst
     |
;
affect : idf sep_eg idf  {
                                   if (variableDejaDeclarer($1)==1)
                                        {
                                            printf("Erreur Semantique a la ligne %d , la variable %s est non declarer\n",yylineo, $1);
                                        }else{
                                          if (variableDejaDeclarer($3)==1)
                                        {
                                            printf("Erreur Semantique a la ligne %d , la variable %s est non declarer\n",yylineo, $3);
                                        }
                                        }
                                    }
      | idf sep_eg val {
                                    if (variableDejaDeclarer($1)==1)
                                        {
                                            printf("Erreur Semantique a la ligne %d , la variable %s est non declarer\n",yylineo, $1);
                                        }
                                    }
      | idf sep_eg operation {
                                    if (variableDejaDeclarer($1)==1)
                                        {
                                            printf("Erreur Semantique a la ligne %d , la variable %s est non declarer\n",yylineo, $1);
                                        }
                                    }
      | idf sep_eg tab {
                                    if (variableDejaDeclarer($1)==1)
                                        {
                                            printf("Erreur Semantique a la ligne %d , la variable %s est non declarer\n",yylineo, $1);
                                        }
                                    }
      | tab sep_eg idf {
                                    if (variableDejaDeclarer($3)==1)
                                        {
                                            printf("Erreur Semantique a la ligne %d , la variable %s est non declarer\n",yylineo, $3);
                                        }
                                    }
      | tab sep_eg val 
      | tab sep_eg operation 
      | tab sep_eg tab
;
operation : idf op idf {
                                    if (variableDejaDeclarer($1)==1)
                                        {
                                            printf("Erreur Semantique a la ligne %d , la variable %s est non declarer\n",yylineo, $1);
                                        }else{
                                          if (variableDejaDeclarer($3)==1)
                                        {
                                            printf("Erreur Semantique a la ligne %d , la variable %s est non declarer\n",yylineo, $3);
                                        }
                                        }
                                    }
          | idf op val {
                                    if (variableDejaDeclarer($1)==1)
                                        {
                                            printf("Erreur Semantique a la ligne %d , la variable %s est non declarer\n",yylineo, $1);
                                        }
                                    }
          | idf op tab {
                                    if (variableDejaDeclarer($1)==1)
                                        {
                                            printf("Erreur Semantique a la ligne %d , la variable %s est non declarer\n",yylineo, $1);
                                        }
                                    }
          | idf op operation {
                                    if (variableDejaDeclarer($1)==1)
                                        {
                                            printf("Erreur Semantique a la ligne %d , la variable %s est non declarer\n",yylineo, $1);
                                        }
                                    }
          | tab op idf {
                                    if (variableDejaDeclarer($3)==1)
                                        {
                                            printf("Erreur Semantique a la ligne %d , la variable %s est non declarer\n",yylineo, $3);
                                        }
                                    }
          | tab op val 
          | tab op tab 
          | tab op operation 
          | val op idf {
                                    if (variableDejaDeclarer($3)==1)
                                        {
                                            printf("Erreur Semantique a la ligne %d , la variable %s est non declarer\n",yylineo, $3);
                                        }
                                    }
          | val op val 
          | val op tab 
          | val op operation 
          | sep_povr operation sep_pfrm 
          | sep_povr operation sep_pfrm op operation
;
op : op_moin 
   | op_plus 
   | op_div 
   | op_mul
;

FOR : mc_for sep_povr idf sep_dp ent sep_dp condition sep_pfrm inst mc_endfor
;
condition :   idf logique idf {
                                    if (variableDejaDeclarer($1)==1)
                                        {
                                            printf("Erreur Semantique a la ligne %d , la variable %s est non declarer\n",yylineo, $1);
                                        }else{
                                          if (variableDejaDeclarer($3)==1)
                                        {
                                            printf("Erreur Semantique a la ligne %d , la variable %s est non declarer\n",yylineo, $3);
                                        }
                                        }
                                    }
        | idf logique val {
                                    if (variableDejaDeclarer($1)==1)
                                        {
                                            printf("Erreur Semantique a la ligne %d , la variable %s est non declarer\n",yylineo, $1);
                                        }
                                    }
        | operation logique idf {
                                    if (variableDejaDeclarer($3)==1)
                                        {
                                            printf("Erreur Semantique a la ligne %d , la variable %s est non declarer\n",yylineo, $3);
                                        }
                                    }
        | 
;
logique : inf 
        | sup 
        | diff 
        | inf_ou_eg 
        | sup_ou_eg 
        | egal
;GET : mc_get sep_povr string sep_dp sep_arob idf sep_pfrm sep_ls {
                                        if (variableDejaDeclarer($6)==1)
                                            {
                                                printf("Erreur Semantique a la ligne %d , la variable %s est non declarer\n",yylineo, $6);
                                            }               
                                        } 
    | mc_get sep_povr string sep_dp sep_arob tab sep_pfrm sep_ls {
                                        $$=$6;
                                        if (variableDejaDeclarer($$)==1)
                                            {
                                                printf("Erreur Semantique a la ligne %d , la variable %s est non declarer\n",yylineo, $$);
                                            }               
                                        }
;
SHOW : mc_show sep_povr string sep_pfrm sep_ls 
     | mc_show sep_povr string sep_dp idf sep_pfrm sep_ls {
                                        if (variableDejaDeclarer($5)==1)
                                            {
                                                printf("Erreur Semantique a la ligne %d , la variable %s est non declarer\n",yylineo, $5);
                                            }
                                    }  
     | mc_show sep_povr string sep_dp tab sep_pfrm sep_ls {
                                        $$=$5;
                                        if (variableDejaDeclarer($$)==1)
                                            {
                                                printf("Erreur Semantique a la ligne %d , la variable %s est non declarer\n",yylineo, $$);
                                            }
                                    }
;
IF : B mc_endif {
                    sprintf(temp,"%d",qc);
                    ajour_quad(fin_if,1,temp);
                }
   | B mc_else sep_acovr inst IF_RETURN sep_acfrm mc_endif
;
B : A sep_acovr inst IF_RETURN operation {
                                fin_if=qc;
                                quadr("BR", "","vide", "vide");
                                sprintf(temp,"%d",qc);
                                ajour_quad(num_quand,nbcol,val);
                            }
;
A :mc_if sep_povr condition sep_pfrm {
                            deb_else=qc; 
                            quadr("BZ", "","temp_cond", "vide");
                        }

;
IF_RETURN : mc_return sep_povr idf sep_pfrm sep_ls {
                                        if (variableDejaDeclarer($3)==1)
                                            {
                                                printf("Erreur Semantique a la ligne %d , la variable %s est non declarer\n",yylineo, $3);
                                            }
                        
                                        }
          
          | mc_return  idf  sep_ls {
                                    if(variableDejaDeclarer($2)==1)
                                        {       
                                            printf("Erreur Semantique a la ligne %d , la variable %s est non declarer\n",yylineo, $2);
                                        }
                        
                                    }
          | mc_return sep_povr val   sep_pfrm sep_ls
          | mc_return  val  sep_ls
          | mc_return operation sep_ls
; 



%%
int yywarp()
{
	return 1;
}
int yyerror(char* msg)
{printf("%s",msg);
printf("\nerreur syntaxique a la yylineo %d et la colonne %d\n",yylineo-1,nbcol-1);
return 1;
}
int main()
{
yyin=fopen("programme.txt","r");
yyparse();
affichage();
return 0;
}