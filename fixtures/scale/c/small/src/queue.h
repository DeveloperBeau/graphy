#ifndef QUEUE_H
#define QUEUE_H

#include "task.h"

struct TaskQueue {
    struct Task *head;
    int count;
};

void queue_init(struct TaskQueue *queue);
void queue_push(struct TaskQueue *queue, struct Task *task);
struct Task *queue_find(struct TaskQueue *queue, unsigned long id);
void queue_remove(struct TaskQueue *queue, unsigned long id);
void queue_clear(struct TaskQueue *queue);

#endif
