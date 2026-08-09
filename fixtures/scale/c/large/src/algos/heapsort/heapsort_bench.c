#include "heapsort.h"
#include "../../core/sample.h"
#include "../../core/timer.h"
#include "../../core/report.h"

double heapsort_bench(void) {
    int n = 512;
    int *arr = sample_make_ints(n, 1666u);
    double start = timer_now_ms();
    heapsort_sort(arr, n);
    double elapsed = timer_elapsed_ms(start);
    report_print_line("heapsort", elapsed, report_is_sorted(arr, n));
    sample_free_ints(arr);
    return elapsed;
}
