/* parses argv into the add/list/complete task-queue commands */
#include "cli.h"
#include "task.h"
#include "priority.h"
#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static void cli_list(struct TaskQueue *queue) {
    struct Task *cur = queue->head;
    while (cur != NULL) {
        printf("[%lu] (%s) %s%s\n", cur->id, priority_label(cur->priority),
               cur->title, cur->done ? " (done)" : "");
        cur = cur->next;
    }
}

int cli_run(int argc, char **argv, struct TaskQueue *queue) {
    if (argc < 2) {
        printf("usage: taskq <add|list|complete> [args]\n");
        return 1;
    }
    if (strcmp(argv[1], "add") == 0 && argc >= 3) {
        enum TaskPriority p = argc >= 4 ? priority_from_string(argv[3]) : PRIORITY_NORMAL;
        struct Task *task = task_create(util_trim(argv[2]), p);
        queue_push(queue, task);
        printf("added task %lu\n", task->id);
        return 0;
    }
    if (strcmp(argv[1], "list") == 0) {
        cli_list(queue);
        return 0;
    }
    if (strcmp(argv[1], "complete") == 0 && argc >= 3) {
        unsigned long id = strtoul(argv[2], NULL, 10);
        struct Task *task = queue_find(queue, id);
        if (task != NULL) {
            task_mark_done(task);
            printf("completed task %lu\n", id);
        }
        return 0;
    }
    printf("unknown command: %s\n", argv[1]);
    return 1;
}
