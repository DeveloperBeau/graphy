/* feature: top-level function, called cross-file */
#include "types.h"
#include <string.h>

char *format_name(const char *name) {
    static char buf[256];
    snprintf(buf, sizeof(buf), "hi, %s", name);
    return buf;
}

int unrelated_helper(void) {
    return 7;
}
