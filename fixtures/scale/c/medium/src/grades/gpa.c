/* rolls per-enrollment grades up into grade point averages */
#include "gpa.h"
#include "calculator.h"
#include "letter.h"
#include <stddef.h>

double gpa_compute(struct Enrollment *enrollment) {
    double percent = calculator_weighted_average(enrollment);
    char letter = letter_from_percent(percent);
    return letter_to_gpa_points(letter);
}

double gpa_compute_cumulative(struct Enrollment *enrollments) {
    double total_points = 0.0;
    int credit_total = 0;
    struct Enrollment *cur = enrollments;
    while (cur != NULL) {
        int hours = cur->course->credit_hours;
        total_points += gpa_compute(cur) * hours;
        credit_total += hours;
        cur = cur->next;
    }
    return credit_total > 0 ? total_points / credit_total : 0.0;
}
