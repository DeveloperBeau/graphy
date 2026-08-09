#include "interpolation_search.h"
#include "../../core/sample.h"
#include "../../core/timer.h"
#include "../../core/report.h"

double interpolation_search_bench(void) {
    int n = 512;
    int *arr = sample_make_ints(n, 2480u);
    sample_sort_ints(arr, n);
    int target = arr[n - 1];
    double start = timer_now_ms();
    int idx = interpolation_search_search(arr, n, target);
    double elapsed = timer_elapsed_ms(start);
    report_print_line("interpolation_search", elapsed, idx >= 0);
    sample_free_ints(arr);
    return elapsed;
}
