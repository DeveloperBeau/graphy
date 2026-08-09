#include "hash_robin_hood.h"
#include "../../core/timer.h"
#include "../../core/report.h"

double hash_robin_hood_bench(void) {
    double start = timer_now_ms();
    struct HashRobinHoodTable *table = hash_robin_hood_table_create(1024);
    for (int i = 0; i < 500; i++) {
        hash_robin_hood_table_insert(table, i, i);
    }
    int ok = hash_robin_hood_table_lookup(table, 250) == 250;
    double elapsed = timer_elapsed_ms(start);
    report_print_line("hash_robin_hood", elapsed, ok);
    hash_robin_hood_table_destroy(table);
    return elapsed;
}
