/* array-backed binary min-heap with sift-up and sift-down */
#include "min_heap.h"
#include <stdlib.h>

struct MinHeapHeap *min_heap_create(int capacity) {
    struct MinHeapHeap *heap = malloc(sizeof(struct MinHeapHeap));
    heap->data = malloc(sizeof(int) * (size_t)capacity);
    heap->size = 0;
    heap->capacity = capacity;
    return heap;
}

static void min_heap_swap(int *a, int *b) {
    int tmp = *a;
    *a = *b;
    *b = tmp;
}

void min_heap_push(struct MinHeapHeap *heap, int value) {
    if (heap->size >= heap->capacity) {
        return;
    }
    int i = heap->size++;
    heap->data[i] = value;
    while (i > 0) {
        int parent = (i - 1) / 2;
        if (heap->data[parent] <= heap->data[i]) {
            break;
        }
        min_heap_swap(&heap->data[parent], &heap->data[i]);
        i = parent;
    }
}

int min_heap_pop_min(struct MinHeapHeap *heap) {
    if (heap->size == 0) {
        return -1;
    }
    int min_val = heap->data[0];
    heap->data[0] = heap->data[--heap->size];
    int i = 0;
    for (;;) {
        int left = 2 * i + 1;
        int right = 2 * i + 2;
        int smallest = i;
        if (left < heap->size && heap->data[left] < heap->data[smallest]) {
            smallest = left;
        }
        if (right < heap->size && heap->data[right] < heap->data[smallest]) {
            smallest = right;
        }
        if (smallest == i) {
            break;
        }
        min_heap_swap(&heap->data[i], &heap->data[smallest]);
        i = smallest;
    }
    return min_val;
}

void min_heap_destroy(struct MinHeapHeap *heap) {
    free(heap->data);
    free(heap);
}
