#include "hash_cuckoo.h"
#include "../../core/timer.h"
#include "../../core/report.h"

double hash_cuckoo_bench(void) {
    double start = timer_now_ms();
    struct HashCuckooTable *table = hash_cuckoo_table_create(1024);
    for (int i = 0; i < 400; i++) {
        hash_cuckoo_table_insert(table, i, i);
    }
    int ok = hash_cuckoo_table_lookup(table, 200) == 200;
    double elapsed = timer_elapsed_ms(start);
    report_print_line("hash_cuckoo", elapsed, ok);
    hash_cuckoo_table_destroy(table);
    return elapsed;
}
