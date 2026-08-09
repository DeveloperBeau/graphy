#ifndef COURSE_H
#define COURSE_H

#include "department.h"

struct Course {
    int id;
    char code[16];
    char title[64];
    int credit_hours;
    struct Department department;
    struct Course *next;
};

struct Course *course_create(const char *code, const char *title, int credit_hours,
                              struct Department department);
void course_free(struct Course *course);

#endif
