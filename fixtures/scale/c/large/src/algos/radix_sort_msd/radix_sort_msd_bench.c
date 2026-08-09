#include "radix_sort_msd.h"
#include "../../core/sample.h"
#include "../../core/timer.h"
#include "../../core/report.h"

double radix_sort_msd_bench(void) {
    int n = 512;
    int *arr = sample_make_ints(n, 1888u);
    double start = timer_now_ms();
    radix_sort_msd_sort(arr, n);
    double elapsed = timer_elapsed_ms(start);
    report_print_line("radix_sort_msd", elapsed, report_is_sorted(arr, n));
    sample_free_ints(arr);
    return elapsed;
}
