#include "hash_double_hash.h"
#include "../../core/report.h"

int hash_double_hash_verify(void) {
    struct HashDoubleHashTable *table = hash_double_hash_table_create(64);
    for (int i = 0; i < 20; i++) {
        hash_double_hash_table_insert(table, i, i * 2);
    }
    int ok = report_check_eq(hash_double_hash_table_lookup(table, 15), 30);
    hash_double_hash_table_destroy(table);
    return ok;
}
