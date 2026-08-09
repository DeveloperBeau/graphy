#include "shell_sort.h"
#include "../../core/sample.h"
#include "../../core/timer.h"
#include "../../core/report.h"

double shell_sort_bench(void) {
    int n = 512;
    int *arr = sample_make_ints(n, 1296u);
    double start = timer_now_ms();
    shell_sort_sort(arr, n);
    double elapsed = timer_elapsed_ms(start);
    report_print_line("shell_sort", elapsed, report_is_sorted(arr, n));
    sample_free_ints(arr);
    return elapsed;
}
