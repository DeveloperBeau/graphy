/* steps forward while sorted, steps back to fix an inversion */
#include "gnome_sort.h"

void gnome_sort_sort(int *arr, int n) {
    int i = 0;
    while (i < n) {
        if (i == 0 || arr[i - 1] <= arr[i]) {
            i++;
        } else {
            int tmp = arr[i];
            arr[i] = arr[i - 1];
            arr[i - 1] = tmp;
            i--;
        }
    }
}
