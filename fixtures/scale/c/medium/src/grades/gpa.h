#ifndef GPA_H
#define GPA_H

#include "../models/enrollment.h"

double gpa_compute(struct Enrollment *enrollment);
double gpa_compute_cumulative(struct Enrollment *enrollments);

#endif
