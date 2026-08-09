#ifndef ALGOS_LRU_CACHE_H
#define ALGOS_LRU_CACHE_H

#define LRU_CACHE_CAPACITY_MAX 64

struct LruCacheCache {
    int keys[LRU_CACHE_CAPACITY_MAX];
    int values[LRU_CACHE_CAPACITY_MAX];
    int last_used[LRU_CACHE_CAPACITY_MAX];
    int count;
    int capacity;
    int clock;
};

struct LruCacheCache *lru_cache_create(int capacity);
void lru_cache_put(struct LruCacheCache *cache, int key, int value);
int lru_cache_get(struct LruCacheCache *cache, int key);
void lru_cache_destroy(struct LruCacheCache *cache);
int lru_cache_verify(void);
double lru_cache_bench(void);

#endif
