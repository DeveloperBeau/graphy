/* counts occurrences of each value in the known 0..999 sample range */
#include "counting_sort.h"
#include <stdlib.h>

void counting_sort_sort(int *arr, int n) {
    int range = 1000;
    int *counts = calloc((size_t)range, sizeof(int));
    for (int i = 0; i < n; i++) {
        counts[arr[i]]++;
    }
    int pos = 0;
    for (int v = 0; v < range; v++) {
        while (counts[v] > 0) {
            arr[pos++] = v;
            counts[v]--;
        }
    }
    free(counts);
}
