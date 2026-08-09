/* small value type describing an academic department */
#include "department.h"
#include <string.h>

struct Department department_make(const char *code, const char *name) {
    struct Department dept;
    strncpy(dept.code, code, sizeof(dept.code) - 1);
    dept.code[sizeof(dept.code) - 1] = '\0';
    strncpy(dept.name, name, sizeof(dept.name) - 1);
    dept.name[sizeof(dept.name) - 1] = '\0';
    return dept;
}

int department_code_matches(const struct Department *dept, const char *code) {
    return strcmp(dept->code, code) == 0;
}
