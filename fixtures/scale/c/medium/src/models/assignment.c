/* one graded item belonging to an enrollment */
#include "assignment.h"
#include <stdlib.h>
#include <string.h>

struct Assignment *assignment_create(const char *name, double earned, double possible,
                                      double weight) {
    struct Assignment *assignment = malloc(sizeof(struct Assignment));
    strncpy(assignment->name, name, sizeof(assignment->name) - 1);
    assignment->name[sizeof(assignment->name) - 1] = '\0';
    assignment->points_earned = earned;
    assignment->points_possible = possible;
    assignment->weight = weight;
    assignment->next = NULL;
    return assignment;
}

void assignment_free(struct Assignment *assignment) {
    free(assignment);
}

double assignment_percent(const struct Assignment *assignment) {
    if (assignment->points_possible <= 0.0) {
        return 0.0;
    }
    return (assignment->points_earned / assignment->points_possible) * 100.0;
}
