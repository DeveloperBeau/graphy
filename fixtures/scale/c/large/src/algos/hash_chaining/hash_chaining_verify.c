#include "hash_chaining.h"
#include "../../core/report.h"

int hash_chaining_verify(void) {
    struct HashChainingTable *table = hash_chaining_table_create(64);
    for (int i = 0; i < 20; i++) {
        hash_chaining_table_insert(table, i, i * 10);
    }
    int ok = report_check_eq(hash_chaining_table_lookup(table, 12), 120);
    hash_chaining_table_destroy(table);
    return ok;
}
