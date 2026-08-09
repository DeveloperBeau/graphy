#include "ternary_search.h"
#include "../../core/sample.h"
#include "../../core/report.h"

int ternary_search_verify(void) {
    int n = 40;
    int *arr = sample_make_ints(n, 2739u);
    sample_sort_ints(arr, n);
    int target = arr[n / 2];
    int idx = ternary_search_search(arr, n, target);
    int ok = report_check_eq(idx >= 0 && arr[idx] == target, 1);
    sample_free_ints(arr);
    return ok;
}
