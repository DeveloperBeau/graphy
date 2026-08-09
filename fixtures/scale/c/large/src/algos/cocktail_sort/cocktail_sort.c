/* bidirectional bubble sort, alternating forward and backward passes */
#include "cocktail_sort.h"

void cocktail_sort_sort(int *arr, int n) {
    int start = 0;
    int end = n - 1;
    int swapped = 1;
    while (swapped) {
        swapped = 0;
        for (int i = start; i < end; i++) {
            if (arr[i] > arr[i + 1]) {
                int tmp = arr[i];
                arr[i] = arr[i + 1];
                arr[i + 1] = tmp;
                swapped = 1;
            }
        }
        if (!swapped) {
            break;
        }
        end--;
        swapped = 0;
        for (int i = end; i > start; i--) {
            if (arr[i - 1] > arr[i]) {
                int tmp = arr[i - 1];
                arr[i - 1] = arr[i];
                arr[i] = tmp;
                swapped = 1;
            }
        }
        start++;
    }
}
