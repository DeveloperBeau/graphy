#ifndef STUDENT_H
#define STUDENT_H

struct Student {
    int id;
    char name[64];
    int active;
    struct Student *next;
};

struct Student *student_create(const char *name);
void student_free(struct Student *student);
void student_deactivate(struct Student *student);

#endif
