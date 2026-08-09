/* flat-file persistence for the task queue, one task per line */
#include "store.h"
#include "task.h"
#include "util.h"
#include <stdio.h>

int store_save(const char *path, struct TaskQueue *queue) {
    FILE *f = fopen(path, "w");
    if (f == NULL) {
        return 0;
    }
    struct Task *cur = queue->head;
    while (cur != NULL) {
        fprintf(f, "%lu|%d|%d|%s\n", cur->id, cur->priority, cur->done, cur->title);
        cur = cur->next;
    }
    fclose(f);
    return 1;
}

int store_load(const char *path, struct TaskQueue *queue) {
    FILE *f = fopen(path, "r");
    if (f == NULL) {
        return 0;
    }
    char line[256];
    while (fgets(line, sizeof(line), f) != NULL) {
        char *trimmed = util_trim(line);
        unsigned long id;
        int priority;
        int done;
        char title[128];
        if (sscanf(trimmed, "%lu|%d|%d|%127[^\n]", &id, &priority, &done, title) == 4) {
            struct Task *task = task_create(title, (enum TaskPriority)priority);
            task->id = id;
            task->done = done;
            queue_push(queue, task);
        }
    }
    fclose(f);
    return 1;
}
