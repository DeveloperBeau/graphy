#include "odd_even_sort.h"
#include "../../core/sample.h"
#include "../../core/report.h"

int odd_even_sort_verify(void) {
    int n = 48;
    int *arr = sample_make_ints(n, 2221u);
    odd_even_sort_sort(arr, n);
    int ok = report_is_sorted(arr, n);
    sample_free_ints(arr);
    return ok;
}
