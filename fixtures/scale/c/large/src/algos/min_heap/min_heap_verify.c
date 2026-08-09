#include "min_heap.h"
#include "../../core/sample.h"

int min_heap_verify(void) {
    int n = 20;
    int *values = sample_make_ints(n, 2101u);
    struct MinHeapHeap *heap = min_heap_create(n);
    for (int i = 0; i < n; i++) {
        min_heap_push(heap, values[i]);
    }
    int prev = -1;
    int ok = 1;
    for (int i = 0; i < n; i++) {
        int v = min_heap_pop_min(heap);
        if (v < prev) {
            ok = 0;
        }
        prev = v;
    }
    min_heap_destroy(heap);
    sample_free_ints(values);
    return ok;
}
