#include "stack_ops.h"
#include "../../core/sample.h"

int stack_ops_verify(void) {
    int n = 10;
    int *values = sample_make_ints(n, 1801u);
    struct StackOpsStack *stack = stack_ops_create(n);
    for (int i = 0; i < n; i++) {
        stack_ops_push(stack, values[i]);
    }
    int ok = 1;
    for (int i = n - 1; i >= 0; i--) {
        int out;
        stack_ops_pop(stack, &out);
        if (out != values[i]) {
            ok = 0;
        }
    }
    stack_ops_destroy(stack);
    sample_free_ints(values);
    return ok;
}
