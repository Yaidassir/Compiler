#include<stdlib.h>
#include<stdio.h>
#include<string.h>

typedef struct T1
{
char name[20];
char code[20];
char Type[20];
char consts[20];
char taille[20];
struct T1 *svt;
}T1;

typedef struct T2
{
 char name[20];
 char code[20];
 struct T2 *svt;
}T2;

T1 *id,*pid;T2 *s,*ps,*mc,*pmc;

void initialisation(char ent[],char nature[],char type[],char cons[],char t[],int y)
    {
        switch(y) //table des id
        {   case 0:{
            T1 *e=malloc(sizeof(T1));
            if (!e) exit(EXIT_FAILURE);
            strcpy(e->name,ent);
            strcpy(e->code,nature);
            strcpy(e->Type,type);
            strcpy(e->consts,"non");
            strcpy(e->taille,t);
            e->svt=NULL;
            id=e;
            pid=e; }break;
            case 1:{
            T2 *e=malloc(sizeof(T2));
            if (!e) exit(EXIT_FAILURE);
            strcpy(e->name,ent);
            strcpy(e->code,nature);
            e->svt=NULL;
            s=e;
            ps=e;  }break;

            case 2:{
            T2 *e=malloc(sizeof(T2));
            if (!e) exit(EXIT_FAILURE);
            strcpy(e->name,ent);
            strcpy(e->code,nature);
            e->svt=NULL;
            mc=e;
            pmc=e;  }break;

        }
    }
void ajouter(char ent[],char nature[],char type[],char cons[],char t[],int y)
{
        switch(y)
        {
            case 0:{
                if (id==NULL) initialisation(ent,nature,type,cons,t,y);
                else{
                T1 *e=malloc(sizeof(T1));
                if (!e) exit(EXIT_FAILURE);
                e->svt=NULL;
                pid->svt=e;
                pid=e;
                strcpy(e->name,ent);
                strcpy(e->code,nature);
                strcpy(e->Type,type);
                strcpy(e->consts,"non");
                strcpy(e->taille,t);
                }}break;
            case 1:{
                if (s==NULL) initialisation(ent,nature,type,cons,t,y);else
                {
                T2 *e=malloc(sizeof(T2));
                if (!e) exit(EXIT_FAILURE);
                e->svt=NULL;
                ps->svt=e;
                ps=e;
                strcpy(e->name,ent);
                strcpy(e->code,nature);
                }}break;

            case 2:{
                if (mc==NULL) initialisation(ent,nature,type,cons,t,y);else
                {
                T2 *e=malloc(sizeof(T2));
                if (!e) exit(EXIT_FAILURE);
                e->svt=NULL;
                pmc->svt=e;
                pmc=e;
                strcpy(e->name,ent);
                strcpy(e->code,nature);
                }}break;
        }
}
void rechercher(char ent[],char nature[],char type[],char cons[],char t[],int y)
{

 switch(y)
  {
   case 0:{ T1 *e;e=id;
     while (e!=NULL && strcmp(ent,e->name))
       {
        e=e->svt;
       }
	if (e==NULL) ajouter(ent,nature,type,cons,t,y);  }break;
   case 1:{ T2 *e;e=s;
        while (e!=NULL && strcmp(ent,e->name))
       {
        e=e->svt;
       }
	if (e==NULL) ajouter(ent,nature,type,cons,t,y); }break;

	case 2:{ T2 *e;e=mc;
        while (e!=NULL && strcmp(ent,e->name))
       {
        e=e->svt;
       }
	if (e==NULL) ajouter(ent,nature,type,cons,t,y); } break;
  }
}
T1* recherche(char entite[]){
  T1 *e;
  e=id;
  while(e != NULL){

    if( strcmp(entite , e->name)==0){
    
        return e;
    }
    else
        e=e->svt;
    
  }
}
void affichage()
{
        T1 *e;e=id;
                printf("\n\t\t\t=============================Table des symboles IDF=====================================\n");
                printf("\t \t \t **************************************************************************************\n");
                printf("\t \t \t     Nom              Code             Type               Constant         Taille      \n");
                printf("\t \t \t ************************************************************************************** \n");
        while (e!=NULL)
            {   
                printf("\t \t \t |%16s|%16s|%16s|%16s|%16s|\n",e->name,e->code,e->Type,e->consts,e->taille);
                e=e->svt;
            }
                printf(" \t \t \t ***************************************************************************************\n");
            T2 *h;h=s;
                printf("\n\t*******************Table des symboles ''séparateurs''**************\n");
                printf("\t \t \t ************************************\n");
                printf("\t \t \t       Nom                Type       \n");
                printf("\t \t \t ************************************\n");
        while (h!=NULL)
            {   
                printf("\t \t \t |");
                printf("   %10s",h->name);
                printf("\t");
                printf("  |   %7s    ",h->code);
                printf("|\n");
                h=h->svt;
            }
                printf(" \t \t \t *************************************\n");
            T2 *m;m=mc;
                printf("\n\t*******************Table des symboles ''mots clés''***************\n");
                printf("\t \t \t ************************************\n");
                printf("\t \t \t        Nom              Type       \n");
                printf("\t \t \t ************************************\n");
        while (m!=NULL)
            {   
                printf("\t \t \t |");
                printf("   %10s",m->name);
                printf("\t");
                printf("  |  %7s     ",m->code);
                printf("|\n");
                m=m->svt;
            }
                printf(" \t \t \t **************************************\n");
}
int variableDejaDeclarer(char entite[]){
   
   T1 *e;
   e=id;
   while(strcmp(e->name, entite)!=0){
             e=e->svt;
   }
         
   if(strcmp(e->Type,"")==0){
        return 1; //variable non declarer
    
   }else return 0; //variable deja declarer
}

void modifierConst(char entite[]){

T1 *e;
   e=id;
   while(strcmp(e->name , entite)!=0){
             e=e->svt;
   }

   strcpy(e->consts,"oui");

}
void ajoutval(char entite[],char t[])
{
  T1 *e;
  e=recherche(entite);
  if(e!= NULL){
    strcpy(e->taille,t);
  }

}
void RemplaceTaille(char entite[] , char t[]){

  
   
   T1 *e;
   e=id;
   while(strcmp(e->name , entite)!=0){
             e=e->svt;
   }
   
   
   strcpy(e->taille,t);

}




int doubleDeclaration(char entite[]){
    T1 *e;
    e=id;

    if(recherche(entite)!=NULL){
       while(strcmp(e->name , entite)!=0){
             e=e->svt;
       }
         
       if(strcmp(e->Type,"")==0){
        return 0;
       }
       else {
        return 1;
       }
    }
    else {
        return 0;
    }
}


void insertType(char entite[] ,char type[]){
    T1 *p2;

    p2=recherche(entite);
    
     strcpy(p2->Type,type);
}
int compType(char entite[] ,char type[]){
    T1 *p2;

    p2=recherche(entite);
    
     if (p2!=NULL)
     {if(strcmp(p2->Type,type)==0){
      return 0;
       
     }else return 1;
     }
}

void insererTYPE(char type[]){
T1 *e;
  e=id;

  while(e != NULL){

    if( strcmp(e->Type,"type select" )==0){
    strcpy(e->Type,type);

    }
    else
        e=e->svt;
    
  }


}

int tailleTableauDepasse(char entite[],char t[]){
  T1 *p2;
  p2=id;
  p2=recherche(entite);
  if (atoi(p2->taille)>atoi(t))
  {
    return 1;
    //pas de depassement
  }else
  {
    return 0;
    //depassement
  }
}


int compatibiliteType(char entite1[],char entite2[])
{

   T1 *q,*p;
    p=recherche(entite1); 
    q=recherche(entite2);
   if((p != NULL)&&(q != NULL))
   {

      
      if(strcmp(p->Type, q->Type)!=0){
        return 1; //type non compatible
      }
      else {
        return 0;  //type compatible
      }


   }
   else {
    return 2;  //variable non declarer
      }
}

