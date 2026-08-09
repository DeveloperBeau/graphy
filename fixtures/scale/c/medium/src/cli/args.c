/* turns argv into a small fixed-shape command struct */
#include "args.h"
#include <stddef.h>

struct ParsedArgs args_parse(int argc, char **argv) {
    struct ParsedArgs parsed;
    parsed.command = argc > 1 ? argv[1] : NULL;
    parsed.arg1 = argc > 2 ? argv[2] : NULL;
    parsed.arg2 = argc > 3 ? argv[3] : NULL;
    return parsed;
}
