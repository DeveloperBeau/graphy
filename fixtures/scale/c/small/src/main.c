/* entry point: loads the queue, runs one command, saves the queue */
#include "queue.h"
#include "cli.h"
#include "store.h"

int main(int argc, char **argv) {
    struct TaskQueue queue;
    queue_init(&queue);
    store_load("tasks.db", &queue);
    int rc = cli_run(argc, argv, &queue);
    store_save("tasks.db", &queue);
    queue_clear(&queue);
    return rc;
}
