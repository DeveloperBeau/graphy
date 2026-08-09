#ifndef CORE_REPORT_H
#define CORE_REPORT_H

int report_is_sorted(const int *arr, int n);
int report_check_eq(int actual, int expected);
void report_print_line(const char *label, double ms, int ok);
void report_summary(int total, int passed);

#endif
