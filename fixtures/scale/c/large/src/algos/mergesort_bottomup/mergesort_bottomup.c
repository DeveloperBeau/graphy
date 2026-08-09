/* iterative merge sort that doubles the run width each pass */
#include "mergesort_bottomup.h"
#include <stdlib.h>

static void mergesort_bottomup_merge(int *arr, int *tmp, int left, int mid, int right) {
    int i = left, j = mid, k = left;
    while (i < mid && j < right) {
        tmp[k++] = (arr[i] <= arr[j]) ? arr[i++] : arr[j++];
    }
    while (i < mid) {
        tmp[k++] = arr[i++];
    }
    while (j < right) {
        tmp[k++] = arr[j++];
    }
    for (int x = left; x < right; x++) {
        arr[x] = tmp[x];
    }
}

void mergesort_bottomup_sort(int *arr, int n) {
    int *tmp = malloc(sizeof(int) * (size_t)n);
    for (int width = 1; width < n; width *= 2) {
        for (int left = 0; left < n; left += 2 * width) {
            int mid = left + width < n ? left + width : n;
            int right = left + 2 * width < n ? left + 2 * width : n;
            mergesort_bottomup_merge(arr, tmp, left, mid, right);
        }
    }
    free(tmp);
}
