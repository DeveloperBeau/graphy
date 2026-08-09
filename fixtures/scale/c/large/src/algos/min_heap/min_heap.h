#ifndef ALGOS_MIN_HEAP_H
#define ALGOS_MIN_HEAP_H

struct MinHeapHeap {
    int *data;
    int size;
    int capacity;
};

struct MinHeapHeap *min_heap_create(int capacity);
void min_heap_push(struct MinHeapHeap *heap, int value);
int min_heap_pop_min(struct MinHeapHeap *heap);
void min_heap_destroy(struct MinHeapHeap *heap);
int min_heap_verify(void);
double min_heap_bench(void);

#endif
