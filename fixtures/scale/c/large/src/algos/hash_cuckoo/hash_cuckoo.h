#ifndef ALGOS_HASH_CUCKOO_H
#define ALGOS_HASH_CUCKOO_H

struct HashCuckooTable {
    int *keys1;
    int *values1;
    int *used1;
    int *keys2;
    int *values2;
    int *used2;
    int capacity;
};

struct HashCuckooTable *hash_cuckoo_table_create(int capacity);
void hash_cuckoo_table_insert(struct HashCuckooTable *table, int key, int value);
int hash_cuckoo_table_lookup(struct HashCuckooTable *table, int key);
void hash_cuckoo_table_destroy(struct HashCuckooTable *table);
int hash_cuckoo_verify(void);
double hash_cuckoo_bench(void);

#endif
