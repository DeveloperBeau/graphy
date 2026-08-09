#include "hash_cuckoo.h"
#include "../../core/report.h"

int hash_cuckoo_verify(void) {
    struct HashCuckooTable *table = hash_cuckoo_table_create(64);
    for (int i = 0; i < 16; i++) {
        hash_cuckoo_table_insert(table, i, i * 5);
    }
    int ok = report_check_eq(hash_cuckoo_table_lookup(table, 6), 30);
    hash_cuckoo_table_destroy(table);
    return ok;
}
