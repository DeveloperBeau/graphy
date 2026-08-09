/* routes a parsed command to the report or grading subsystem */
#include "commands.h"
#include "../reports/roster.h"
#include "../reports/summary.h"
#include "../reports/honor_roll.h"
#include <stdio.h>
#include <string.h>

int commands_dispatch(struct ParsedArgs args, struct GradeDb *db, struct Gradebook *book) {
    if (args.command == NULL) {
        printf("usage: gradetrack <roster|average|honors>\n");
        return 1;
    }
    if (strcmp(args.command, "roster") == 0) {
        roster_print(db);
        return 0;
    }
    if (strcmp(args.command, "average") == 0) {
        summary_print_class_average(book);
        return 0;
    }
    if (strcmp(args.command, "honors") == 0) {
        honor_roll_print(book, 3.5);
        return 0;
    }
    printf("unknown command: %s\n", args.command);
    return 1;
}
