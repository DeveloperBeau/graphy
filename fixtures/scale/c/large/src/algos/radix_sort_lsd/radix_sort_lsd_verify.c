#include "radix_sort_lsd.h"
#include "../../core/sample.h"
#include "../../core/report.h"

int radix_sort_lsd_verify(void) {
    int n = 48;
    int *arr = sample_make_ints(n, 1777u);
    radix_sort_lsd_sort(arr, n);
    int ok = report_is_sorted(arr, n);
    sample_free_ints(arr);
    return ok;
}
