#include "hash_chaining.h"
#include "../../core/timer.h"
#include "../../core/report.h"

double hash_chaining_bench(void) {
    double start = timer_now_ms();
    struct HashChainingTable *table = hash_chaining_table_create(256);
    for (int i = 0; i < 500; i++) {
        hash_chaining_table_insert(table, i, i);
    }
    int ok = hash_chaining_table_lookup(table, 250) == 250;
    double elapsed = timer_elapsed_ms(start);
    report_print_line("hash_chaining", elapsed, ok);
    hash_chaining_table_destroy(table);
    return elapsed;
}
