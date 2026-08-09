#include "queue_ops.h"
#include "../../core/sample.h"

int queue_ops_verify(void) {
    int n = 10;
    int *values = sample_make_ints(n, 1901u);
    struct QueueOpsQueue *queue = queue_ops_create(n);
    for (int i = 0; i < n; i++) {
        queue_ops_enqueue(queue, values[i]);
    }
    int ok = 1;
    for (int i = 0; i < n; i++) {
        int out;
        queue_ops_dequeue(queue, &out);
        if (out != values[i]) {
            ok = 0;
        }
    }
    queue_ops_destroy(queue);
    sample_free_ints(values);
    return ok;
}
