#include "bst_ops.h"
#include "../../core/sample.h"
#include "../../core/timer.h"
#include "../../core/report.h"
#include <stddef.h>

double bst_ops_bench(void) {
    int n = 256;
    int *values = sample_make_ints(n, 2002u);
    double start = timer_now_ms();
    struct BstOpsNode *root = NULL;
    for (int i = 0; i < n; i++) {
        root = bst_ops_insert(root, values[i]);
    }
    int found = bst_ops_find(root, values[0]);
    double elapsed = timer_elapsed_ms(start);
    report_print_line("bst_ops", elapsed, found);
    bst_ops_free(root);
    sample_free_ints(values);
    return elapsed;
}
