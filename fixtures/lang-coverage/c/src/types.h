/* feature: struct, enum, #include system */
#ifndef TYPES_H
#define TYPES_H

#include <stddef.h>

enum State { STATE_IDLE, STATE_RUNNING, STATE_DONE };

struct Point {
    int x;
    int y;
};

struct Service {
    char *name;
    enum State state;
};

#endif /* TYPES_H */
