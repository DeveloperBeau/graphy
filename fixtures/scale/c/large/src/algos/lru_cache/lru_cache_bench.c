#include "lru_cache.h"
#include "../../core/timer.h"
#include "../../core/report.h"

double lru_cache_bench(void) {
    double start = timer_now_ms();
    struct LruCacheCache *cache = lru_cache_create(32);
    for (int i = 0; i < 200; i++) {
        lru_cache_put(cache, i % 40, i);
    }
    int hit = lru_cache_get(cache, 39);
    double elapsed = timer_elapsed_ms(start);
    report_print_line("lru_cache", elapsed, hit >= 0);
    lru_cache_destroy(cache);
    return elapsed;
}
