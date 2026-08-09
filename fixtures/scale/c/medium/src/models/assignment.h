#ifndef ASSIGNMENT_H
#define ASSIGNMENT_H

struct Assignment {
    char name[64];
    double points_earned;
    double points_possible;
    double weight;
    struct Assignment *next;
};

struct Assignment *assignment_create(const char *name, double earned, double possible,
                                      double weight);
void assignment_free(struct Assignment *assignment);
double assignment_percent(const struct Assignment *assignment);

#endif
