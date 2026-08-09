#include "lru_cache.h"

int lru_cache_verify(void) {
    struct LruCacheCache *cache = lru_cache_create(2);
    lru_cache_put(cache, 1, 100);
    lru_cache_put(cache, 2, 200);
    lru_cache_get(cache, 1);
    lru_cache_put(cache, 3, 300);
    int ok = lru_cache_get(cache, 1) == 100 && lru_cache_get(cache, 2) == -1;
    lru_cache_destroy(cache);
    return ok;
}
