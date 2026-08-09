/* quicksort using Hoare's original two-pointer partition scheme */
#include "quicksort_hoare.h"

static int quicksort_hoare_partition(int *arr, int low, int high) {
    int pivot = arr[low];
    int i = low - 1;
    int j = high + 1;
    for (;;) {
        do {
            i++;
        } while (arr[i] < pivot);
        do {
            j--;
        } while (arr[j] > pivot);
        if (i >= j) {
            return j;
        }
        int tmp = arr[i];
        arr[i] = arr[j];
        arr[j] = tmp;
    }
}

static void quicksort_hoare_recurse(int *arr, int low, int high) {
    if (low < high) {
        int p = quicksort_hoare_partition(arr, low, high);
        quicksort_hoare_recurse(arr, low, p);
        quicksort_hoare_recurse(arr, p + 1, high);
    }
}

void quicksort_hoare_sort(int *arr, int n) {
    quicksort_hoare_recurse(arr, 0, n - 1);
}
