#ifndef GRADEBOOK_H
#define GRADEBOOK_H

#include "../models/enrollment.h"

struct Gradebook {
    struct Enrollment *enrollments;
    int count;
};

void gradebook_init(struct Gradebook *book);
void gradebook_add_enrollment(struct Gradebook *book, struct Enrollment *enrollment);
struct Enrollment *gradebook_find(struct Gradebook *book, int enrollment_id);

#endif
