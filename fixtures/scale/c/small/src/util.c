/* small string and id helpers shared across the task queue */
#include "util.h"
#include <ctype.h>
#include <string.h>

static unsigned long util_id_counter = 1000;

char *util_trim(char *s) {
    while (*s && isspace((unsigned char)*s)) {
        s++;
    }
    size_t len = strlen(s);
    while (len > 0 && isspace((unsigned char)s[len - 1])) {
        s[--len] = '\0';
    }
    return s;
}

unsigned long util_gen_id(void) {
    return util_id_counter++;
}
