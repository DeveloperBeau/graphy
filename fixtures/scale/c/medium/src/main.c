/* wires together the store, gradebook, and cli for the grade tracker */
#include "cli/args.h"
#include "cli/commands.h"
#include "store/db.h"
#include "grades/gradebook.h"
#include "reports/transcript.h"

int main(int argc, char **argv) {
    struct GradeDb db;
    db_init(&db);
    struct Gradebook book;
    gradebook_init(&book);

    struct ParsedArgs args = args_parse(argc, argv);
    int rc = commands_dispatch(args, &db, &book);
    return rc;
}
