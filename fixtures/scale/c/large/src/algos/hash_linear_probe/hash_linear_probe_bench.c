#include "hash_linear_probe.h"
#include "../../core/timer.h"
#include "../../core/report.h"

double hash_linear_probe_bench(void) {
    double start = timer_now_ms();
    struct HashLinearProbeTable *table = hash_linear_probe_table_create(1024);
    for (int i = 0; i < 500; i++) {
        hash_linear_probe_table_insert(table, i, i);
    }
    int ok = hash_linear_probe_table_lookup(table, 250) == 250;
    double elapsed = timer_elapsed_ms(start);
    report_print_line("hash_linear_probe", elapsed, ok);
    hash_linear_probe_table_destroy(table);
    return elapsed;
}
