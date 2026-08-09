#ifndef ALGOS_HASH_DOUBLE_HASH_H
#define ALGOS_HASH_DOUBLE_HASH_H

struct HashDoubleHashTable {
    int *keys;
    int *values;
    int *used;
    int capacity;
};

struct HashDoubleHashTable *hash_double_hash_table_create(int capacity);
void hash_double_hash_table_insert(struct HashDoubleHashTable *table, int key, int value);
int hash_double_hash_table_lookup(struct HashDoubleHashTable *table, int key);
void hash_double_hash_table_destroy(struct HashDoubleHashTable *table);
int hash_double_hash_verify(void);
double hash_double_hash_bench(void);

#endif
