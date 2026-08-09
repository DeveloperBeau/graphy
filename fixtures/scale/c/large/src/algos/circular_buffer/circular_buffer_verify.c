#include "circular_buffer.h"
#include "../../core/sample.h"

int circular_buffer_verify(void) {
    int n = 8;
    int *values = sample_make_ints(n, 2201u);
    struct CircularBufferBuffer *buf = circular_buffer_create(n);
    for (int i = 0; i < n; i++) {
        circular_buffer_push(buf, values[i]);
    }
    int ok = 1;
    for (int i = 0; i < n; i++) {
        int out;
        circular_buffer_pop(buf, &out);
        if (out != values[i]) {
            ok = 0;
        }
    }
    circular_buffer_destroy(buf);
    sample_free_ints(values);
    return ok;
}
