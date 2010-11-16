
#ifndef NODH
#define NODH

#define NAME_LENGTH 40

struct post {
    char name[NAME_LENGTH];
    float bmi;
    struct post* next;
    struct post* previous;
};

typedef struct post Post;

void writePost(Post * p);

void writeList(Post * p);

/* find tar en funktionspekare som första parameter */
Post * find(int (* compare) (Post * a, Post * b), Post seeked, Post * list);

int compare_names(Post * a, Post * b);

int compare_bmi(Post * a, Post * b);

void insert(Post ** list);

Post* removePost(Post* p);

void load_names(char * filename, Post ** list);

#endif // _NODH

