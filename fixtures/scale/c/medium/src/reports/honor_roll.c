/* lists students whose gpa clears the honor roll threshold */
#include "honor_roll.h"
#include "../grades/gpa.h"
#include <stdio.h>

void honor_roll_print(struct Gradebook *book, double gpa_threshold) {
    struct Enrollment *cur = book->enrollments;
    while (cur != NULL) {
        double points = gpa_compute(cur);
        if (points >= gpa_threshold) {
            printf("honor roll: %s (%.2f)\n", cur->student->name, points);
        }
        cur = cur->next;
    }
}
