/* turns an enrollment's graded assignments into a percentage */
#include "calculator.h"
#include "weighting.h"
#include <stddef.h>

double calculator_simple_average(struct Enrollment *enrollment) {
    double total = 0.0;
    int count = 0;
    struct Assignment *cur = enrollment->assignments;
    while (cur != NULL) {
        total += assignment_percent(cur);
        count++;
        cur = cur->next;
    }
    return count > 0 ? total / count : 0.0;
}

double calculator_weighted_average(struct Enrollment *enrollment) {
    double total_weight = weighting_total(enrollment);
    double weighted_sum = 0.0;
    struct Assignment *cur = enrollment->assignments;
    while (cur != NULL) {
        double share = weighting_normalize(cur->weight, total_weight);
        weighted_sum += assignment_percent(cur) * share;
        cur = cur->next;
    }
    return weighted_sum;
}
