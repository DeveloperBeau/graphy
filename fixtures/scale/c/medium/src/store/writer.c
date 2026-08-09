/* serializes the roster back out to disk */
#include "writer.h"
#include <stdio.h>

int writer_write_all(const char *path, struct GradeDb *db) {
    FILE *f = fopen(path, "w");
    if (f == NULL) {
        return 0;
    }
    struct Student *s = db->students;
    while (s != NULL) {
        fprintf(f, "student|%d|%s\n", s->id, s->name);
        s = s->next;
    }
    struct Course *c = db->courses;
    while (c != NULL) {
        fprintf(f, "course|%d|%s|%s\n", c->id, c->code, c->title);
        c = c->next;
    }
    fclose(f);
    return 1;
}
