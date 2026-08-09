/* owns a single course catalog entry */
#include "course.h"
#include "../util/idgen.h"
#include <stdlib.h>
#include <string.h>

struct Course *course_create(const char *code, const char *title, int credit_hours,
                              struct Department department) {
    struct Course *course = malloc(sizeof(struct Course));
    course->id = idgen_next_course_id();
    strncpy(course->code, code, sizeof(course->code) - 1);
    course->code[sizeof(course->code) - 1] = '\0';
    strncpy(course->title, title, sizeof(course->title) - 1);
    course->title[sizeof(course->title) - 1] = '\0';
    course->credit_hours = credit_hours;
    course->department = department;
    course->next = NULL;
    return course;
}

void course_free(struct Course *course) {
    free(course);
}
