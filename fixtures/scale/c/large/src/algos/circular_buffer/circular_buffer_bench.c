#include "circular_buffer.h"
#include "../../core/sample.h"
#include "../../core/timer.h"
#include "../../core/report.h"

double circular_buffer_bench(void) {
    int n = 256;
    int *values = sample_make_ints(n, 2202u);
    double start = timer_now_ms();
    struct CircularBufferBuffer *buf = circular_buffer_create(n);
    for (int i = 0; i < n; i++) {
        circular_buffer_push(buf, values[i]);
    }
    int out;
    for (int i = 0; i < n; i++) {
        circular_buffer_pop(buf, &out);
    }
    double elapsed = timer_elapsed_ms(start);
    report_print_line("circular_buffer", elapsed, 1);
    circular_buffer_destroy(buf);
    sample_free_ints(values);
    return elapsed;
}
