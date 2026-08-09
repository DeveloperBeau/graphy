/* builds a binary max-heap in place, then repeatedly extracts the max */
#include "heapsort.h"

static void heapsort_heapify(int *arr, int n, int root) {
    int largest = root;
    int left = 2 * root + 1;
    int right = 2 * root + 2;
    if (left < n && arr[left] > arr[largest]) {
        largest = left;
    }
    if (right < n && arr[right] > arr[largest]) {
        largest = right;
    }
    if (largest != root) {
        int tmp = arr[root];
        arr[root] = arr[largest];
        arr[largest] = tmp;
        heapsort_heapify(arr, n, largest);
    }
}

void heapsort_sort(int *arr, int n) {
    for (int i = n / 2 - 1; i >= 0; i--) {
        heapsort_heapify(arr, n, i);
    }
    for (int i = n - 1; i > 0; i--) {
        int tmp = arr[0];
        arr[0] = arr[i];
        arr[i] = tmp;
        heapsort_heapify(arr, i, 0);
    }
}
