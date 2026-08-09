/* keeps track of every enrollment being graded this term */
#include "gradebook.h"
#include <stddef.h>

void gradebook_init(struct Gradebook *book) {
    book->enrollments = NULL;
    book->count = 0;
}

void gradebook_add_enrollment(struct Gradebook *book, struct Enrollment *enrollment) {
    enrollment->next = book->enrollments;
    book->enrollments = enrollment;
    book->count++;
}

struct Enrollment *gradebook_find(struct Gradebook *book, int enrollment_id) {
    struct Enrollment *cur = book->enrollments;
    while (cur != NULL) {
        if (cur->id == enrollment_id) {
            return cur;
        }
        cur = cur->next;
    }
    return NULL;
}
