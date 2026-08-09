#ifndef WEIGHTING_H
#define WEIGHTING_H

#include "../models/enrollment.h"

double weighting_total(struct Enrollment *enrollment);
double weighting_normalize(double weight, double total_weight);

#endif
