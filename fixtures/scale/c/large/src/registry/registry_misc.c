/* runs every misc family's verify and bench entry points */
#include "registry_misc.h"
#include "../algos/stack_ops/stack_ops.h"
#include "../algos/queue_ops/queue_ops.h"
#include "../algos/bst_ops/bst_ops.h"
#include "../algos/min_heap/min_heap.h"
#include "../algos/union_find/union_find.h"
#include "../algos/trie_ops/trie_ops.h"
#include "../algos/lru_cache/lru_cache.h"
#include "../algos/circular_buffer/circular_buffer.h"

void registry_run_misc(int *total, int *passed) {
    (*total)++;
    if (stack_ops_verify()) {
        (*passed)++;
    }
    stack_ops_bench();
    (*total)++;
    if (queue_ops_verify()) {
        (*passed)++;
    }
    queue_ops_bench();
    (*total)++;
    if (bst_ops_verify()) {
        (*passed)++;
    }
    bst_ops_bench();
    (*total)++;
    if (min_heap_verify()) {
        (*passed)++;
    }
    min_heap_bench();
    (*total)++;
    if (union_find_verify()) {
        (*passed)++;
    }
    union_find_bench();
    (*total)++;
    if (trie_ops_verify()) {
        (*passed)++;
    }
    trie_ops_bench();
    (*total)++;
    if (lru_cache_verify()) {
        (*passed)++;
    }
    lru_cache_bench();
    (*total)++;
    if (circular_buffer_verify()) {
        (*passed)++;
    }
    circular_buffer_bench();
}
