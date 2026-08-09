#ifndef CALCULATOR_H
#define CALCULATOR_H

#include "../models/enrollment.h"

double calculator_simple_average(struct Enrollment *enrollment);
double calculator_weighted_average(struct Enrollment *enrollment);

#endif
