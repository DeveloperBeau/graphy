/* minimal calendar-date validation and formatting */
#include "dateutil.h"
#include <stdio.h>

int dateutil_is_valid(struct SimpleDate date) {
    if (date.month < 1 || date.month > 12) {
        return 0;
    }
    if (date.day < 1 || date.day > 31) {
        return 0;
    }
    return date.year >= 1900 && date.year <= 3000;
}

void dateutil_format(struct SimpleDate date, char *out, int out_size) {
    snprintf(out, (size_t)out_size, "%04d-%02d-%02d", date.year, date.month, date.day);
}
