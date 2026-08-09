#ifndef LOADER_H
#define LOADER_H

#include "db.h"

int loader_load_students(const char *path, struct GradeDb *db);
int loader_load_courses(const char *path, struct GradeDb *db);

#endif
