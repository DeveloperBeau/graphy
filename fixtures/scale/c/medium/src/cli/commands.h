#ifndef COMMANDS_H
#define COMMANDS_H

#include "args.h"
#include "../store/db.h"
#include "../grades/gradebook.h"

int commands_dispatch(struct ParsedArgs args, struct GradeDb *db, struct Gradebook *book);

#endif
