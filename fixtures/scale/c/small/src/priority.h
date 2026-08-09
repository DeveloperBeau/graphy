#ifndef PRIORITY_H
#define PRIORITY_H

enum TaskPriority {
    PRIORITY_LOW,
    PRIORITY_NORMAL,
    PRIORITY_HIGH,
    PRIORITY_URGENT
};

enum TaskPriority priority_from_string(const char *text);
const char *priority_label(enum TaskPriority priority);

#endif
