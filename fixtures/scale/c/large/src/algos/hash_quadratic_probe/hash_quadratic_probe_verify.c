#include "hash_quadratic_probe.h"
#include "../../core/report.h"

int hash_quadratic_probe_verify(void) {
    struct HashQuadraticProbeTable *table = hash_quadratic_probe_table_create(64);
    for (int i = 0; i < 20; i++) {
        hash_quadratic_probe_table_insert(table, i, i + 5);
    }
    int ok = report_check_eq(hash_quadratic_probe_table_lookup(table, 10), 15);
    hash_quadratic_probe_table_destroy(table);
    return ok;
}
