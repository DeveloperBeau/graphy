#include "ternary_search.h"
#include "../../core/sample.h"
#include "../../core/timer.h"
#include "../../core/report.h"

double ternary_search_bench(void) {
    int n = 512;
    int *arr = sample_make_ints(n, 2776u);
    sample_sort_ints(arr, n);
    int target = arr[n - 1];
    double start = timer_now_ms();
    int idx = ternary_search_search(arr, n, target);
    double elapsed = timer_elapsed_ms(start);
    report_print_line("ternary_search", elapsed, idx >= 0);
    sample_free_ints(arr);
    return elapsed;
}
