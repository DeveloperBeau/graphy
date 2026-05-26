/* feature: function definitions, #include local and system,
   cross-file call (format_name), external call (printf must not produce local edge) */
#include <stdio.h>
#include <stdlib.h>
#include "types.h"
#include "helpers.h"

struct Service *service_new(const char *name) {
    struct Service *s = malloc(sizeof(struct Service));
    s->name = (char *)name;
    s->state = STATE_IDLE;
    return s;
}

void service_run(struct Service *s) {
    char *greeting = format_name(s->name);
    printf("%s\n", greeting);
    s->state = STATE_RUNNING;
}

void service_free(struct Service *s) {
    free(s);
}
