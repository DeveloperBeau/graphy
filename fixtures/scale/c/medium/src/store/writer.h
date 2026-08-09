#ifndef WRITER_H
#define WRITER_H

#include "db.h"

int writer_write_all(const char *path, struct GradeDb *db);

#endif
