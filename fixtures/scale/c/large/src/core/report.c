/* shared pass/fail bookkeeping and console output */
#include "report.h"
#include <stdio.h>

int report_is_sorted(const int *arr, int n) {
    for (int i = 1; i < n; i++) {
        if (arr[i - 1] > arr[i]) {
            return 0;
        }
    }
    return 1;
}

int report_check_eq(int actual, int expected) {
    return actual == expected;
}

void report_print_line(const char *label, double ms, int ok) {
    printf("%-32s %8.4f ms  %s\n", label, ms, ok ? "ok" : "FAIL");
}

void report_summary(int total, int passed) {
    printf("summary: %d/%d checks passed\n", passed, total);
}
