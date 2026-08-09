#include "jump_search.h"
#include "../../core/sample.h"
#include "../../core/timer.h"
#include "../../core/report.h"

double jump_search_bench(void) {
    int n = 512;
    int *arr = sample_make_ints(n, 2628u);
    sample_sort_ints(arr, n);
    int target = arr[n - 1];
    double start = timer_now_ms();
    int idx = jump_search_search(arr, n, target);
    double elapsed = timer_elapsed_ms(start);
    report_print_line("jump_search", elapsed, idx >= 0);
    sample_free_ints(arr);
    return elapsed;
}
