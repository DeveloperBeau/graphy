#ifndef ALGOS_CIRCULAR_BUFFER_H
#define ALGOS_CIRCULAR_BUFFER_H

struct CircularBufferBuffer {
    int *data;
    int head;
    int tail;
    int count;
    int capacity;
};

struct CircularBufferBuffer *circular_buffer_create(int capacity);
int circular_buffer_push(struct CircularBufferBuffer *buf, int value);
int circular_buffer_pop(struct CircularBufferBuffer *buf, int *out);
void circular_buffer_destroy(struct CircularBufferBuffer *buf);
int circular_buffer_verify(void);
double circular_buffer_bench(void);

#endif
