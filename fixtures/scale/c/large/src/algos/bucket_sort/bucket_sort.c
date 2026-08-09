/* distributes values into ten ranged buckets, then insertion-sorts each */
#include "bucket_sort.h"
#include <stdlib.h>

#define BUCKET_SORT_NUM_BUCKETS 10

static void bucket_sort_insertion(int *bucket, int count) {
    for (int i = 1; i < count; i++) {
        int key = bucket[i];
        int j = i - 1;
        while (j >= 0 && bucket[j] > key) {
            bucket[j + 1] = bucket[j];
            j--;
        }
        bucket[j + 1] = key;
    }
}

void bucket_sort_sort(int *arr, int n) {
    int bucket_counts[BUCKET_SORT_NUM_BUCKETS] = {0};
    int *buckets[BUCKET_SORT_NUM_BUCKETS];
    for (int i = 0; i < n; i++) {
        bucket_counts[arr[i] / 100]++;
    }
    for (int b = 0; b < BUCKET_SORT_NUM_BUCKETS; b++) {
        buckets[b] = bucket_counts[b] > 0 ? malloc(sizeof(int) * (size_t)bucket_counts[b]) : NULL;
    }
    int fill[BUCKET_SORT_NUM_BUCKETS] = {0};
    for (int i = 0; i < n; i++) {
        int b = arr[i] / 100;
        buckets[b][fill[b]++] = arr[i];
    }
    int pos = 0;
    for (int b = 0; b < BUCKET_SORT_NUM_BUCKETS; b++) {
        bucket_sort_insertion(buckets[b], bucket_counts[b]);
        for (int i = 0; i < bucket_counts[b]; i++) {
            arr[pos++] = buckets[b][i];
        }
        free(buckets[b]);
    }
}
