/* runs every hashing family's verify and bench entry points */
#include "registry_hashing.h"
#include "../algos/hash_chaining/hash_chaining.h"
#include "../algos/hash_linear_probe/hash_linear_probe.h"
#include "../algos/hash_quadratic_probe/hash_quadratic_probe.h"
#include "../algos/hash_double_hash/hash_double_hash.h"
#include "../algos/hash_robin_hood/hash_robin_hood.h"
#include "../algos/hash_cuckoo/hash_cuckoo.h"

void registry_run_hashing(int *total, int *passed) {
    (*total)++;
    if (hash_chaining_verify()) {
        (*passed)++;
    }
    hash_chaining_bench();
    (*total)++;
    if (hash_linear_probe_verify()) {
        (*passed)++;
    }
    hash_linear_probe_bench();
    (*total)++;
    if (hash_quadratic_probe_verify()) {
        (*passed)++;
    }
    hash_quadratic_probe_bench();
    (*total)++;
    if (hash_double_hash_verify()) {
        (*passed)++;
    }
    hash_double_hash_bench();
    (*total)++;
    if (hash_robin_hood_verify()) {
        (*passed)++;
    }
    hash_robin_hood_bench();
    (*total)++;
    if (hash_cuckoo_verify()) {
        (*passed)++;
    }
    hash_cuckoo_bench();
}
