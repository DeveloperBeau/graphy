#include "queue_ops.h"
#include "../../core/sample.h"
#include "../../core/timer.h"
#include "../../core/report.h"

double queue_ops_bench(void) {
    int n = 512;
    int *values = sample_make_ints(n, 1902u);
    double start = timer_now_ms();
    struct QueueOpsQueue *queue = queue_ops_create(n);
    for (int i = 0; i < n; i++) {
        queue_ops_enqueue(queue, values[i]);
    }
    int out;
    for (int i = 0; i < n; i++) {
        queue_ops_dequeue(queue, &out);
    }
    double elapsed = timer_elapsed_ms(start);
    report_print_line("queue_ops", elapsed, 1);
    queue_ops_destroy(queue);
    sample_free_ints(values);
    return elapsed;
}
