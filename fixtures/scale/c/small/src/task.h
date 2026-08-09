#ifndef TASK_H
#define TASK_H

#include "priority.h"

struct Task {
    unsigned long id;
    char title[128];
    enum TaskPriority priority;
    int done;
    struct Task *next;
};

struct Task *task_create(const char *title, enum TaskPriority priority);
void task_free(struct Task *task);
void task_mark_done(struct Task *task);

#endif
