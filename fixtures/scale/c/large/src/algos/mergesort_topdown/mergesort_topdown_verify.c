#include "mergesort_topdown.h"
#include "../../core/sample.h"
#include "../../core/report.h"

int mergesort_topdown_verify(void) {
    int n = 48;
    int *arr = sample_make_ints(n, 1481u);
    mergesort_topdown_sort(arr, n);
    int ok = report_is_sorted(arr, n);
    sample_free_ints(arr);
    return ok;
}
