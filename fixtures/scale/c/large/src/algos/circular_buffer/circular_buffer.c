/* fixed-size ring buffer used for FIFO byte-like integer streams */
#include "circular_buffer.h"
#include <stdlib.h>

struct CircularBufferBuffer *circular_buffer_create(int capacity) {
    struct CircularBufferBuffer *buf = malloc(sizeof(struct CircularBufferBuffer));
    buf->data = malloc(sizeof(int) * (size_t)capacity);
    buf->head = 0;
    buf->tail = 0;
    buf->count = 0;
    buf->capacity = capacity;
    return buf;
}

int circular_buffer_push(struct CircularBufferBuffer *buf, int value) {
    if (buf->count >= buf->capacity) {
        return 0;
    }
    buf->data[buf->tail] = value;
    buf->tail = (buf->tail + 1) % buf->capacity;
    buf->count++;
    return 1;
}

int circular_buffer_pop(struct CircularBufferBuffer *buf, int *out) {
    if (buf->count == 0) {
        return 0;
    }
    *out = buf->data[buf->head];
    buf->head = (buf->head + 1) % buf->capacity;
    buf->count--;
    return 1;
}

void circular_buffer_destroy(struct CircularBufferBuffer *buf) {
    free(buf->data);
    free(buf);
}
