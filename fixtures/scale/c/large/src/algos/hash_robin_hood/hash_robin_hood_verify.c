#include "hash_robin_hood.h"
#include "../../core/report.h"

int hash_robin_hood_verify(void) {
    struct HashRobinHoodTable *table = hash_robin_hood_table_create(64);
    for (int i = 0; i < 20; i++) {
        hash_robin_hood_table_insert(table, i, i * 4);
    }
    int ok = report_check_eq(hash_robin_hood_table_lookup(table, 7), 28);
    hash_robin_hood_table_destroy(table);
    return ok;
}
