/* finds a bounding range by doubling, then binary searches within it */
#include "exponential_search.h"

static int exponential_search_binary_range(const int *arr, int low, int high, int target) {
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] == target) {
            return mid;
        }
        if (arr[mid] < target) {
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return -1;
}

int exponential_search_search(const int *arr, int n, int target) {
    if (n == 0) {
        return -1;
    }
    if (arr[0] == target) {
        return 0;
    }
    int bound = 1;
    while (bound < n && arr[bound] <= target) {
        bound *= 2;
    }
    int low = bound / 2;
    int high = bound < n ? bound : n - 1;
    return exponential_search_binary_range(arr, low, high, target);
}
