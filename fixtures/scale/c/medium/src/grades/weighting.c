/* normalizes assignment weights so they sum to one */
#include "weighting.h"
#include <stddef.h>

double weighting_total(struct Enrollment *enrollment) {
    double total = 0.0;
    struct Assignment *cur = enrollment->assignments;
    while (cur != NULL) {
        total += cur->weight;
        cur = cur->next;
    }
    return total;
}

double weighting_normalize(double weight, double total_weight) {
    if (total_weight <= 0.0) {
        return 0.0;
    }
    return weight / total_weight;
}
