#include "stack_ops.h"
#include "../../core/sample.h"
#include "../../core/timer.h"
#include "../../core/report.h"

double stack_ops_bench(void) {
    int n = 512;
    int *values = sample_make_ints(n, 1802u);
    double start = timer_now_ms();
    struct StackOpsStack *stack = stack_ops_create(n);
    for (int i = 0; i < n; i++) {
        stack_ops_push(stack, values[i]);
    }
    int out;
    for (int i = 0; i < n; i++) {
        stack_ops_pop(stack, &out);
    }
    double elapsed = timer_elapsed_ms(start);
    report_print_line("stack_ops", elapsed, 1);
    stack_ops_destroy(stack);
    sample_free_ints(values);
    return elapsed;
}
