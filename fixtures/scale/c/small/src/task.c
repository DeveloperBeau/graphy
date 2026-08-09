/* owns the lifecycle of a single task record */
#include "task.h"
#include "util.h"
#include <stdlib.h>
#include <string.h>

struct Task *task_create(const char *title, enum TaskPriority priority) {
    struct Task *task = malloc(sizeof(struct Task));
    task->id = util_gen_id();
    strncpy(task->title, title, sizeof(task->title) - 1);
    task->title[sizeof(task->title) - 1] = '\0';
    task->priority = priority;
    task->done = 0;
    task->next = NULL;
    return task;
}

void task_free(struct Task *task) {
    free(task);
}

void task_mark_done(struct Task *task) {
    task->done = 1;
}
