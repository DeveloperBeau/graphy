#include "mergesort_bottomup.h"
#include "../../core/sample.h"
#include "../../core/timer.h"
#include "../../core/report.h"

double mergesort_bottomup_bench(void) {
    int n = 512;
    int *arr = sample_make_ints(n, 1592u);
    double start = timer_now_ms();
    mergesort_bottomup_sort(arr, n);
    double elapsed = timer_elapsed_ms(start);
    report_print_line("mergesort_bottomup", elapsed, report_is_sorted(arr, n));
    sample_free_ints(arr);
    return elapsed;
}
