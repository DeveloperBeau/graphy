#include "mergesort_bottomup.h"
#include "../../core/sample.h"
#include "../../core/report.h"

int mergesort_bottomup_verify(void) {
    int n = 48;
    int *arr = sample_make_ints(n, 1555u);
    mergesort_bottomup_sort(arr, n);
    int ok = report_is_sorted(arr, n);
    sample_free_ints(arr);
    return ok;
}
