/* prints every graded course for a single student */
#include "transcript.h"
#include "../grades/gpa.h"
#include "../grades/letter.h"
#include <stdio.h>

void transcript_print(struct Student *student, struct Enrollment *enrollments) {
    printf("transcript for %s\n", student->name);
    struct Enrollment *cur = enrollments;
    while (cur != NULL) {
        if (cur->student->id == student->id) {
            double gpa_points = gpa_compute(cur);
            printf("  %s: %.2f gpa points\n", cur->course->code, gpa_points);
        }
        cur = cur->next;
    }
}
