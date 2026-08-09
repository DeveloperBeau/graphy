/* aggregates every enrollment's grade into one class average */
#include "summary.h"
#include "../grades/calculator.h"
#include <stdio.h>

void summary_print_class_average(struct Gradebook *book) {
    double total = 0.0;
    int count = 0;
    struct Enrollment *cur = book->enrollments;
    while (cur != NULL) {
        total += calculator_weighted_average(cur);
        count++;
        cur = cur->next;
    }
    double avg = count > 0 ? total / count : 0.0;
    printf("class average across %d enrollments: %.2f%%\n", count, avg);
}
