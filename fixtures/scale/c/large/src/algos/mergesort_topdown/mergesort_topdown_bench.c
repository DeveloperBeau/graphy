#include "mergesort_topdown.h"
#include "../../core/sample.h"
#include "../../core/timer.h"
#include "../../core/report.h"

double mergesort_topdown_bench(void) {
    int n = 512;
    int *arr = sample_make_ints(n, 1518u);
    double start = timer_now_ms();
    mergesort_topdown_sort(arr, n);
    double elapsed = timer_elapsed_ms(start);
    report_print_line("mergesort_topdown", elapsed, report_is_sorted(arr, n));
    sample_free_ints(arr);
    return elapsed;
}
