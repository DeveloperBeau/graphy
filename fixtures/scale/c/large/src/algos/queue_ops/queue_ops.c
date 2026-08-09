/* array-backed circular FIFO queue with a fixed capacity */
#include "queue_ops.h"
#include <stdlib.h>

struct QueueOpsQueue *queue_ops_create(int capacity) {
    struct QueueOpsQueue *queue = malloc(sizeof(struct QueueOpsQueue));
    queue->data = malloc(sizeof(int) * (size_t)capacity);
    queue->head = 0;
    queue->tail = 0;
    queue->count = 0;
    queue->capacity = capacity;
    return queue;
}

int queue_ops_enqueue(struct QueueOpsQueue *queue, int value) {
    if (queue->count >= queue->capacity) {
        return 0;
    }
    queue->data[queue->tail] = value;
    queue->tail = (queue->tail + 1) % queue->capacity;
    queue->count++;
    return 1;
}

int queue_ops_dequeue(struct QueueOpsQueue *queue, int *out) {
    if (queue->count == 0) {
        return 0;
    }
    *out = queue->data[queue->head];
    queue->head = (queue->head + 1) % queue->capacity;
    queue->count--;
    return 1;
}

void queue_ops_destroy(struct QueueOpsQueue *queue) {
    free(queue->data);
    free(queue);
}
