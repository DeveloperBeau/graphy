/* bubble sort with a shrinking comparison gap to clear turtles early */
#include "comb_sort.h"

void comb_sort_sort(int *arr, int n) {
    int gap = n;
    int swapped = 1;
    while (gap > 1 || swapped) {
        gap = (gap * 10) / 13;
        if (gap < 1) {
            gap = 1;
        }
        swapped = 0;
        for (int i = 0; i + gap < n; i++) {
            if (arr[i] > arr[i + gap]) {
                int tmp = arr[i];
                arr[i] = arr[i + gap];
                arr[i + gap] = tmp;
                swapped = 1;
            }
        }
    }
}
