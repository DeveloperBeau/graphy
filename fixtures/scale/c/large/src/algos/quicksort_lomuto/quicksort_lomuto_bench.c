#include "quicksort_lomuto.h"
#include "../../core/sample.h"
#include "../../core/timer.h"
#include "../../core/report.h"

double quicksort_lomuto_bench(void) {
    int n = 512;
    int *arr = sample_make_ints(n, 1370u);
    double start = timer_now_ms();
    quicksort_lomuto_sort(arr, n);
    double elapsed = timer_elapsed_ms(start);
    report_print_line("quicksort_lomuto", elapsed, report_is_sorted(arr, n));
    sample_free_ints(arr);
    return elapsed;
}
