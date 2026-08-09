/* quicksort using a Lomuto partition scheme around the last element */
#include "quicksort_lomuto.h"

static int quicksort_lomuto_partition(int *arr, int low, int high) {
    int pivot = arr[high];
    int i = low - 1;
    for (int j = low; j < high; j++) {
        if (arr[j] <= pivot) {
            i++;
            int tmp = arr[i];
            arr[i] = arr[j];
            arr[j] = tmp;
        }
    }
    int tmp = arr[i + 1];
    arr[i + 1] = arr[high];
    arr[high] = tmp;
    return i + 1;
}

static void quicksort_lomuto_recurse(int *arr, int low, int high) {
    if (low < high) {
        int p = quicksort_lomuto_partition(arr, low, high);
        quicksort_lomuto_recurse(arr, low, p - 1);
        quicksort_lomuto_recurse(arr, p + 1, high);
    }
}

void quicksort_lomuto_sort(int *arr, int n) {
    quicksort_lomuto_recurse(arr, 0, n - 1);
}
