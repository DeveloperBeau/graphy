/* least-significant-digit radix sort using base-10 counting passes */
#include "radix_sort_lsd.h"
#include <stdlib.h>

static int radix_sort_lsd_max_value(const int *arr, int n) {
    int max_val = arr[0];
    for (int i = 1; i < n; i++) {
        if (arr[i] > max_val) {
            max_val = arr[i];
        }
    }
    return max_val;
}

static void radix_sort_lsd_counting_pass(int *arr, int n, int exp) {
    int *output = malloc(sizeof(int) * (size_t)n);
    int counts[10] = {0};
    for (int i = 0; i < n; i++) {
        counts[(arr[i] / exp) % 10]++;
    }
    for (int i = 1; i < 10; i++) {
        counts[i] += counts[i - 1];
    }
    for (int i = n - 1; i >= 0; i--) {
        int digit = (arr[i] / exp) % 10;
        output[--counts[digit]] = arr[i];
    }
    for (int i = 0; i < n; i++) {
        arr[i] = output[i];
    }
    free(output);
}

void radix_sort_lsd_sort(int *arr, int n) {
    int max_val = radix_sort_lsd_max_value(arr, n);
    for (int exp = 1; max_val / exp > 0; exp *= 10) {
        radix_sort_lsd_counting_pass(arr, n, exp);
    }
}
