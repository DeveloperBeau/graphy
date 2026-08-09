/* generates and sorts small integer arrays used across every benchmark */
#include "sample.h"
#include "rng.h"
#include <stdlib.h>

static int sample_compare_ints(const void *a, const void *b) {
    int ia = *(const int *)a;
    int ib = *(const int *)b;
    return ia - ib;
}

int *sample_make_ints(int n, unsigned int seed) {
    int *arr = malloc(sizeof(int) * (size_t)n);
    unsigned int state = seed;
    for (int i = 0; i < n; i++) {
        arr[i] = (int)(rng_next(&state) % 1000u);
    }
    return arr;
}

void sample_sort_ints(int *arr, int n) {
    qsort(arr, (size_t)n, sizeof(int), sample_compare_ints);
}

void sample_free_ints(int *arr) {
    free(arr);
}
