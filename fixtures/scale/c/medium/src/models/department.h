#ifndef DEPARTMENT_H
#define DEPARTMENT_H

struct Department {
    char code[8];
    char name[64];
};

struct Department department_make(const char *code, const char *name);
int department_code_matches(const struct Department *dept, const char *code);

#endif
