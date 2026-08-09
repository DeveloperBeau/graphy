/* reads pipe-delimited student and course rosters from disk */
#include "loader.h"
#include "../models/department.h"
#include "../util/strutil.h"
#include <stdio.h>

int loader_load_students(const char *path, struct GradeDb *db) {
    FILE *f = fopen(path, "r");
    if (f == NULL) {
        return 0;
    }
    char line[128];
    while (fgets(line, sizeof(line), f) != NULL) {
        char *name = strutil_trim(line);
        if (*name == '\0') {
            continue;
        }
        db_add_student(db, student_create(name));
    }
    fclose(f);
    return 1;
}

int loader_load_courses(const char *path, struct GradeDb *db) {
    FILE *f = fopen(path, "r");
    if (f == NULL) {
        return 0;
    }
    char line[128];
    while (fgets(line, sizeof(line), f) != NULL) {
        char code[16];
        char title[64];
        int hours;
        if (sscanf(line, "%15[^|]|%63[^|]|%d", code, title, &hours) == 3) {
            struct Department dept = department_make("GEN", "General Studies");
            db_add_course(db, course_create(code, title, hours, dept));
        }
    }
    fclose(f);
    return 1;
}
