/* lists every active student and catalog course */
#include "roster.h"
#include <stdio.h>

void roster_print(struct GradeDb *db) {
    struct Student *s = db->students;
    while (s != NULL) {
        if (s->active) {
            printf("student %d: %s\n", s->id, s->name);
        }
        s = s->next;
    }
    struct Course *c = db->courses;
    while (c != NULL) {
        printf("course %s: %s (%d credit hours)\n", c->code, c->title, c->credit_hours);
        c = c->next;
    }
}
