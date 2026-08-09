/* owns a single enrolled student record */
#include "student.h"
#include "../util/idgen.h"
#include "../util/strutil.h"
#include <stdlib.h>
#include <string.h>

struct Student *student_create(const char *name) {
    struct Student *student = malloc(sizeof(struct Student));
    student->id = idgen_next_student_id();
    strncpy(student->name, name, sizeof(student->name) - 1);
    student->name[sizeof(student->name) - 1] = '\0';
    student->active = 1;
    student->next = NULL;
    return student;
}

void student_free(struct Student *student) {
    free(student);
}

void student_deactivate(struct Student *student) {
    student->active = 0;
}
