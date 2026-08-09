/* fixed-capacity cache that evicts whichever entry was used longest ago */
#include "lru_cache.h"
#include <stdlib.h>

struct LruCacheCache *lru_cache_create(int capacity) {
    struct LruCacheCache *cache = malloc(sizeof(struct LruCacheCache));
    cache->count = 0;
    cache->capacity = capacity < LRU_CACHE_CAPACITY_MAX ? capacity : LRU_CACHE_CAPACITY_MAX;
    cache->clock = 0;
    return cache;
}

static int lru_cache_find_index(struct LruCacheCache *cache, int key) {
    for (int i = 0; i < cache->count; i++) {
        if (cache->keys[i] == key) {
            return i;
        }
    }
    return -1;
}

static int lru_cache_find_oldest(struct LruCacheCache *cache) {
    int oldest = 0;
    for (int i = 1; i < cache->count; i++) {
        if (cache->last_used[i] < cache->last_used[oldest]) {
            oldest = i;
        }
    }
    return oldest;
}

void lru_cache_put(struct LruCacheCache *cache, int key, int value) {
    int idx = lru_cache_find_index(cache, key);
    cache->clock++;
    if (idx >= 0) {
        cache->values[idx] = value;
        cache->last_used[idx] = cache->clock;
        return;
    }
    if (cache->count < cache->capacity) {
        idx = cache->count++;
    } else {
        idx = lru_cache_find_oldest(cache);
    }
    cache->keys[idx] = key;
    cache->values[idx] = value;
    cache->last_used[idx] = cache->clock;
}

int lru_cache_get(struct LruCacheCache *cache, int key) {
    int idx = lru_cache_find_index(cache, key);
    if (idx < 0) {
        return -1;
    }
    cache->clock++;
    cache->last_used[idx] = cache->clock;
    return cache->values[idx];
}

void lru_cache_destroy(struct LruCacheCache *cache) {
    free(cache);
}
