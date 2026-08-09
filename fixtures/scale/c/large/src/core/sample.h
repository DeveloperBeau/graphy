#ifndef CORE_SAMPLE_H
#define CORE_SAMPLE_H

int *sample_make_ints(int n, unsigned int seed);
void sample_sort_ints(int *arr, int n);
void sample_free_ints(int *arr);

#endif
