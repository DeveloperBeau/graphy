/* most-significant-digit radix sort, recursing into per-digit buckets */
#include "radix_sort_msd.h"
#include <stdlib.h>
#include <string.h>

static void radix_sort_msd_recurse(int *arr, int n, int exp) {
    if (n <= 1 || exp == 0) {
        return;
    }
    int counts[10] = {0};
    for (int i = 0; i < n; i++) {
        counts[(arr[i] / exp) % 10]++;
    }
    int *buckets[10];
    for (int d = 0; d < 10; d++) {
        buckets[d] = counts[d] > 0 ? malloc(sizeof(int) * (size_t)counts[d]) : NULL;
    }
    int fill[10] = {0};
    for (int i = 0; i < n; i++) {
        int d = (arr[i] / exp) % 10;
        buckets[d][fill[d]++] = arr[i];
    }
    int pos = 0;
    for (int d = 0; d < 10; d++) {
        if (counts[d] > 0) {
            radix_sort_msd_recurse(buckets[d], counts[d], exp / 10);
            memcpy(arr + pos, buckets[d], sizeof(int) * (size_t)counts[d]);
            pos += counts[d];
            free(buckets[d]);
        }
    }
}

void radix_sort_msd_sort(int *arr, int n) {
    radix_sort_msd_recurse(arr, n, 100);
}
