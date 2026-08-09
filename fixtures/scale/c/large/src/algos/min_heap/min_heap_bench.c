#include "min_heap.h"
#include "../../core/sample.h"
#include "../../core/timer.h"
#include "../../core/report.h"

double min_heap_bench(void) {
    int n = 512;
    int *values = sample_make_ints(n, 2102u);
    double start = timer_now_ms();
    struct MinHeapHeap *heap = min_heap_create(n);
    for (int i = 0; i < n; i++) {
        min_heap_push(heap, values[i]);
    }
    int last = -1;
    for (int i = 0; i < n; i++) {
        last = min_heap_pop_min(heap);
    }
    double elapsed = timer_elapsed_ms(start);
    report_print_line("min_heap", elapsed, last >= 0);
    min_heap_destroy(heap);
    sample_free_ints(values);
    return elapsed;
}
