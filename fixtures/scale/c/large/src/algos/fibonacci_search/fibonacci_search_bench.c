#include "fibonacci_search.h"
#include "../../core/sample.h"
#include "../../core/timer.h"
#include "../../core/report.h"

double fibonacci_search_bench(void) {
    int n = 512;
    int *arr = sample_make_ints(n, 2702u);
    sample_sort_ints(arr, n);
    int target = arr[n - 1];
    double start = timer_now_ms();
    int idx = fibonacci_search_search(arr, n, target);
    double elapsed = timer_elapsed_ms(start);
    report_print_line("fibonacci_search", elapsed, idx >= 0);
    sample_free_ints(arr);
    return elapsed;
}
