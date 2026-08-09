/* reads one trimmed line of interactive input */
#include "prompt.h"
#include "../util/strutil.h"
#include <stdio.h>

void prompt_read_line(char *buf, int buf_size) {
    if (fgets(buf, buf_size, stdin) != NULL) {
        strutil_trim(buf);
    } else {
        buf[0] = '\0';
    }
}
