#include "cocktail_sort.h"
#include "../../core/sample.h"
#include "../../core/timer.h"
#include "../../core/report.h"

double cocktail_sort_bench(void) {
    int n = 512;
    int *arr = sample_make_ints(n, 2036u);
    double start = timer_now_ms();
    cocktail_sort_sort(arr, n);
    double elapsed = timer_elapsed_ms(start);
    report_print_line("cocktail_sort", elapsed, report_is_sorted(arr, n));
    sample_free_ints(arr);
    return elapsed;
}
