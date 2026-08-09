#ifndef STORE_H
#define STORE_H

#include "queue.h"

int store_save(const char *path, struct TaskQueue *queue);
int store_load(const char *path, struct TaskQueue *queue);

#endif
