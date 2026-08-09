/* links one student to one course and its graded assignments */
#include "enrollment.h"
#include "../util/idgen.h"
#include <stdlib.h>

struct Enrollment *enrollment_create(struct Student *student, struct Course *course) {
    struct Enrollment *enrollment = malloc(sizeof(struct Enrollment));
    enrollment->id = idgen_next_enrollment_id();
    enrollment->student = student;
    enrollment->course = course;
    enrollment->assignments = NULL;
    enrollment->next = NULL;
    return enrollment;
}

void enrollment_add_assignment(struct Enrollment *enrollment, struct Assignment *assignment) {
    assignment->next = enrollment->assignments;
    enrollment->assignments = assignment;
}

void enrollment_free(struct Enrollment *enrollment) {
    struct Assignment *cur = enrollment->assignments;
    while (cur != NULL) {
        struct Assignment *next = cur->next;
        assignment_free(cur);
        cur = next;
    }
    free(enrollment);
}
