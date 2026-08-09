/* sorts using only prefix flips, like stacking pancakes by size */
#include "pancake_sort.h"

static void pancake_sort_flip(int *arr, int k) {
    int start = 0;
    while (start < k) {
        int tmp = arr[start];
        arr[start] = arr[k];
        arr[k] = tmp;
        start++;
        k--;
    }
}

static int pancake_sort_max_index(const int *arr, int n) {
    int max_idx = 0;
    for (int i = 1; i < n; i++) {
        if (arr[i] > arr[max_idx]) {
            max_idx = i;
        }
    }
    return max_idx;
}

void pancake_sort_sort(int *arr, int n) {
    for (int size = n; size > 1; size--) {
        int max_idx = pancake_sort_max_index(arr, size);
        if (max_idx != size - 1) {
            pancake_sort_flip(arr, max_idx);
            pancake_sort_flip(arr, size - 1);
        }
    }
}
