/* skips ahead in fixed-size blocks, then scans the block linearly */
#include "jump_search.h"

int jump_search_search(const int *arr, int n, int target) {
    int step = 1;
    while (step * step < n) {
        step++;
    }
    int prev = 0;
    int cur = step;
    while (cur < n && arr[cur - 1] < target) {
        prev = cur;
        cur += step;
    }
    int limit = cur < n ? cur : n;
    for (int i = prev; i < limit; i++) {
        if (arr[i] == target) {
            return i;
        }
    }
    return -1;
}
