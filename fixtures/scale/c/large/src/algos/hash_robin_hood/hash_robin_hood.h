#ifndef ALGOS_HASH_ROBIN_HOOD_H
#define ALGOS_HASH_ROBIN_HOOD_H

struct HashRobinHoodTable {
    int *keys;
    int *values;
    int *dist;
    int *used;
    int capacity;
};

struct HashRobinHoodTable *hash_robin_hood_table_create(int capacity);
void hash_robin_hood_table_insert(struct HashRobinHoodTable *table, int key, int value);
int hash_robin_hood_table_lookup(struct HashRobinHoodTable *table, int key);
void hash_robin_hood_table_destroy(struct HashRobinHoodTable *table);
int hash_robin_hood_verify(void);
double hash_robin_hood_bench(void);

#endif
