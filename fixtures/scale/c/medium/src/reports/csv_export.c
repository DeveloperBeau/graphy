/* dumps each enrollment's weighted grade as a csv row */
#include "csv_export.h"
#include "../grades/calculator.h"
#include <stdio.h>

int csv_export_grades(const char *path, struct Gradebook *book) {
    FILE *f = fopen(path, "w");
    if (f == NULL) {
        return 0;
    }
    fprintf(f, "student,course,percent\n");
    struct Enrollment *cur = book->enrollments;
    while (cur != NULL) {
        double percent = calculator_weighted_average(cur);
        fprintf(f, "%s,%s,%.2f\n", cur->student->name, cur->course->code, percent);
        cur = cur->next;
    }
    fclose(f);
    return 1;
}
