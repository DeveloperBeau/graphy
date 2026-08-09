#include "radix_sort_msd.h"
#include "../../core/sample.h"
#include "../../core/report.h"

int radix_sort_msd_verify(void) {
    int n = 48;
    int *arr = sample_make_ints(n, 1851u);
    radix_sort_msd_sort(arr, n);
    int ok = report_is_sorted(arr, n);
    sample_free_ints(arr);
    return ok;
}
