#include "quicksort_lomuto.h"
#include "../../core/sample.h"
#include "../../core/report.h"

int quicksort_lomuto_verify(void) {
    int n = 48;
    int *arr = sample_make_ints(n, 1333u);
    quicksort_lomuto_sort(arr, n);
    int ok = report_is_sorted(arr, n);
    sample_free_ints(arr);
    return ok;
}
