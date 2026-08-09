#ifndef ENROLLMENT_H
#define ENROLLMENT_H

#include "student.h"
#include "course.h"
#include "assignment.h"

struct Enrollment {
    int id;
    struct Student *student;
    struct Course *course;
    struct Assignment *assignments;
    struct Enrollment *next;
};

struct Enrollment *enrollment_create(struct Student *student, struct Course *course);
void enrollment_add_assignment(struct Enrollment *enrollment, struct Assignment *assignment);
void enrollment_free(struct Enrollment *enrollment);

#endif
