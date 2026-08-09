#include "hash_double_hash.h"
#include "../../core/timer.h"
#include "../../core/report.h"

double hash_double_hash_bench(void) {
    double start = timer_now_ms();
    struct HashDoubleHashTable *table = hash_double_hash_table_create(1024);
    for (int i = 0; i < 500; i++) {
        hash_double_hash_table_insert(table, i, i);
    }
    int ok = hash_double_hash_table_lookup(table, 250) == 250;
    double elapsed = timer_elapsed_ms(start);
    report_print_line("hash_double_hash", elapsed, ok);
    hash_double_hash_table_destroy(table);
    return elapsed;
}
