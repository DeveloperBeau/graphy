#include "hash_linear_probe.h"
#include "../../core/report.h"

int hash_linear_probe_verify(void) {
    struct HashLinearProbeTable *table = hash_linear_probe_table_create(64);
    for (int i = 0; i < 20; i++) {
        hash_linear_probe_table_insert(table, i, i * 3);
    }
    int ok = report_check_eq(hash_linear_probe_table_lookup(table, 9), 27);
    hash_linear_probe_table_destroy(table);
    return ok;
}
