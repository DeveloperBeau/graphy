#include "bst_ops.h"
#include "../../core/sample.h"
#include <stddef.h>

int bst_ops_verify(void) {
    int n = 20;
    int *values = sample_make_ints(n, 2001u);
    struct BstOpsNode *root = NULL;
    for (int i = 0; i < n; i++) {
        root = bst_ops_insert(root, values[i]);
    }
    int ok = bst_ops_find(root, values[0]) && !bst_ops_find(root, -1);
    bst_ops_free(root);
    sample_free_ints(values);
    return ok;
}
