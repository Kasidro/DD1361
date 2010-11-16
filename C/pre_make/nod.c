#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "nod.h"

void writePost(Post * p) {
    printf("Namn: %s\nbmi:%.2f\n\n", p->name, p->bmi);
}

void writeList(Post * p) {
    while(p) {
        writePost(p);
        p = p->next;
    }
}

Post* find(int (*compare) (Post*  a, Post* b), Post seeked, Post* list) {
    while(list) {
        if((*compare)(&seeked, list) == 0)
            return list;

        list = list->next;
    }

    return 1;
}

int compare_names(Post * a, Post * b) {
    char *namea = a->name,
         *nameb = b->name;

    while(*namea && *nameb) {
        if(*namea != *nameb)
            return 1;

        namea++;
        nameb++;
    }

    return 0;
}

int compare_bmi(Post * a, Post * b) {
    float bmia = a->bmi,
          bmib = b->bmi;

    return bmia == bmib ? 0 : 1;
}

void insert(Post ** list) {
    Post* p;
    char name[NAME_LENGTH];
    int weight;
    float height;

    printf("Vad heter personen? ");
    scanf("%s", (char*) &name);

    printf("Hur lång är personen (m)? ");
    scanf("%f", &height);

    printf("Hur mycket v�ger personen (KG) ");
    scanf("%d", &weight);

    p = (Post*)malloc(sizeof(Post));
    strcpy(p->name, name);
    p->bmi = weight / height / height;

    p->next = *list;
    (**list).previous = p;
    *list = p;
}

Post* removePost(Post* p) {
    if(!p->previous)
        return p->next;

    // We are guaranteed to have a previous element here
    if(!p->next) {
        p->previous->next = NULL;

        while(p->previous)
            p = p->previous;

        return p;
    }

    // We have both a previous and a next element
    p->previous->next = p->next;
    p->next->previous = p->previous;

    while(p->previous)
        p = p->previous;

    return p;
}

void load_names(char * filename, Post ** list) {
    char name[NAME_LENGTH];
    float bmi;
    FILE *fil = fopen(filename, "r");
    Post * p;

    int first = 1;

    if (fil == NULL) {
	    printf("Filen inte funnen.\n");
    } else {
        while (fscanf(fil, "%s %f", name, &bmi) == 2) {
            p = (Post *) malloc(sizeof(Post));
            strcpy(p->name, name);
            p->bmi = bmi;
            
            p->next = *list;

            if(!first) {
                (**list).previous = p;
                first = 0;
            }

            *list = p;
        }
    }
}
