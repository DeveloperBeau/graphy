#ifndef DATEUTIL_H
#define DATEUTIL_H

struct SimpleDate {
    int year;
    int month;
    int day;
};

int dateutil_is_valid(struct SimpleDate date);
void dateutil_format(struct SimpleDate date, char *out, int out_size);

#endif
