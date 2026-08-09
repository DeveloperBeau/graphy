#ifndef ALGOS_QUEUE_OPS_H
#define ALGOS_QUEUE_OPS_H

struct QueueOpsQueue {
    int *data;
    int head;
    int tail;
    int count;
    int capacity;
};

struct QueueOpsQueue *queue_ops_create(int capacity);
int queue_ops_enqueue(struct QueueOpsQueue *queue, int value);
int queue_ops_dequeue(struct QueueOpsQueue *queue, int *out);
void queue_ops_destroy(struct QueueOpsQueue *queue);
int queue_ops_verify(void);
double queue_ops_bench(void);

#endif
