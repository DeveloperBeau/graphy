#ifndef CSV_EXPORT_H
#define CSV_EXPORT_H

#include "../grades/gradebook.h"

int csv_export_grades(const char *path, struct Gradebook *book);

#endif
