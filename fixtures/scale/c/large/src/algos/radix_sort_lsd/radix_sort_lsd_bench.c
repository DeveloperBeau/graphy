#include "radix_sort_lsd.h"
#include "../../core/sample.h"
#include "../../core/timer.h"
#include "../../core/report.h"

double radix_sort_lsd_bench(void) {
    int n = 512;
    int *arr = sample_make_ints(n, 1814u);
    double start = timer_now_ms();
    radix_sort_lsd_sort(arr, n);
    double elapsed = timer_elapsed_ms(start);
    report_print_line("radix_sort_lsd", elapsed, report_is_sorted(arr, n));
    sample_free_ints(arr);
    return elapsed;
}
