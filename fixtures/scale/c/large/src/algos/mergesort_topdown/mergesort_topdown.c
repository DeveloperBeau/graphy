/* classic recursive divide-and-conquer merge sort */
#include "mergesort_topdown.h"
#include <stdlib.h>

static void mergesort_topdown_merge(int *arr, int left, int mid, int right) {
    int n1 = mid - left + 1;
    int n2 = right - mid;
    int *left_arr = malloc(sizeof(int) * (size_t)n1);
    int *right_arr = malloc(sizeof(int) * (size_t)n2);
    for (int i = 0; i < n1; i++) {
        left_arr[i] = arr[left + i];
    }
    for (int j = 0; j < n2; j++) {
        right_arr[j] = arr[mid + 1 + j];
    }
    int i = 0, j = 0, k = left;
    while (i < n1 && j < n2) {
        arr[k++] = (left_arr[i] <= right_arr[j]) ? left_arr[i++] : right_arr[j++];
    }
    while (i < n1) {
        arr[k++] = left_arr[i++];
    }
    while (j < n2) {
        arr[k++] = right_arr[j++];
    }
    free(left_arr);
    free(right_arr);
}

static void mergesort_topdown_recurse(int *arr, int left, int right) {
    if (left < right) {
        int mid = left + (right - left) / 2;
        mergesort_topdown_recurse(arr, left, mid);
        mergesort_topdown_recurse(arr, mid + 1, right);
        mergesort_topdown_merge(arr, left, mid, right);
    }
}

void mergesort_topdown_sort(int *arr, int n) {
    if (n > 1) {
        mergesort_topdown_recurse(arr, 0, n - 1);
    }
}
