/* estimates the probe position from the target's value, not the midpoint */
#include "interpolation_search.h"

int interpolation_search_search(const int *arr, int n, int target) {
    int low = 0;
    int high = n - 1;
    while (low <= high && target >= arr[low] && target <= arr[high]) {
        if (arr[high] == arr[low]) {
            return arr[low] == target ? low : -1;
        }
        int pos = low + (int)(((long)(target - arr[low]) * (high - low)) /
                               (arr[high] - arr[low]));
        if (arr[pos] == target) {
            return pos;
        }
        if (arr[pos] < target) {
            low = pos + 1;
        } else {
            high = pos - 1;
        }
    }
    return -1;
}
