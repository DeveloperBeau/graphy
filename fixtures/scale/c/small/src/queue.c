/* singly linked task list kept sorted by descending priority */
#include "queue.h"
#include <stddef.h>

void queue_init(struct TaskQueue *queue) {
    queue->head = NULL;
    queue->count = 0;
}

void queue_push(struct TaskQueue *queue, struct Task *task) {
    if (queue->head == NULL || task->priority > queue->head->priority) {
        task->next = queue->head;
        queue->head = task;
    } else {
        struct Task *cur = queue->head;
        while (cur->next != NULL && cur->next->priority >= task->priority) {
            cur = cur->next;
        }
        task->next = cur->next;
        cur->next = task;
    }
    queue->count++;
}

struct Task *queue_find(struct TaskQueue *queue, unsigned long id) {
    struct Task *cur = queue->head;
    while (cur != NULL) {
        if (cur->id == id) {
            return cur;
        }
        cur = cur->next;
    }
    return NULL;
}

void queue_remove(struct TaskQueue *queue, unsigned long id) {
    struct Task *prev = NULL;
    struct Task *cur = queue->head;
    while (cur != NULL) {
        if (cur->id == id) {
            if (prev == NULL) {
                queue->head = cur->next;
            } else {
                prev->next = cur->next;
            }
            task_free(cur);
            queue->count--;
            return;
        }
        prev = cur;
        cur = cur->next;
    }
}

void queue_clear(struct TaskQueue *queue) {
    struct Task *cur = queue->head;
    while (cur != NULL) {
        struct Task *next = cur->next;
        task_free(cur);
        cur = next;
    }
    queue->head = NULL;
    queue->count = 0;
}
