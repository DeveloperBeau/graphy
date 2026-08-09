/* splits the search range into three parts instead of two */
#include "ternary_search.h"

static int ternary_search_recurse(const int *arr, int low, int high, int target) {
    if (low > high) {
        return -1;
    }
    int third = (high - low) / 3;
    int mid1 = low + third;
    int mid2 = high - third;
    if (arr[mid1] == target) {
        return mid1;
    }
    if (arr[mid2] == target) {
        return mid2;
    }
    if (target < arr[mid1]) {
        return ternary_search_recurse(arr, low, mid1 - 1, target);
    }
    if (target > arr[mid2]) {
        return ternary_search_recurse(arr, mid2 + 1, high, target);
    }
    return ternary_search_recurse(arr, mid1 + 1, mid2 - 1, target);
}

int ternary_search_search(const int *arr, int n, int target) {
    return ternary_search_recurse(arr, 0, n - 1, target);
}
