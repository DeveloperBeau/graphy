#include "pancake_sort.h"
#include "../../core/sample.h"
#include "../../core/timer.h"
#include "../../core/report.h"

double pancake_sort_bench(void) {
    int n = 512;
    int *arr = sample_make_ints(n, 2332u);
    double start = timer_now_ms();
    pancake_sort_sort(arr, n);
    double elapsed = timer_elapsed_ms(start);
    report_print_line("pancake_sort", elapsed, report_is_sorted(arr, n));
    sample_free_ints(arr);
    return elapsed;
}
