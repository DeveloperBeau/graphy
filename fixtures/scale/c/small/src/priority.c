/* maps between the command-line priority words and the enum values */
#include "priority.h"
#include <string.h>

enum TaskPriority priority_from_string(const char *text) {
    if (strcmp(text, "urgent") == 0) {
        return PRIORITY_URGENT;
    }
    if (strcmp(text, "high") == 0) {
        return PRIORITY_HIGH;
    }
    if (strcmp(text, "low") == 0) {
        return PRIORITY_LOW;
    }
    return PRIORITY_NORMAL;
}

const char *priority_label(enum TaskPriority priority) {
    switch (priority) {
        case PRIORITY_LOW: return "low";
        case PRIORITY_HIGH: return "high";
        case PRIORITY_URGENT: return "urgent";
        default: return "normal";
    }
}
