#ifndef ALGOS_HASH_LINEAR_PROBE_H
#define ALGOS_HASH_LINEAR_PROBE_H

struct HashLinearProbeTable {
    int *keys;
    int *values;
    int *used;
    int capacity;
};

struct HashLinearProbeTable *hash_linear_probe_table_create(int capacity);
void hash_linear_probe_table_insert(struct HashLinearProbeTable *table, int key, int value);
int hash_linear_probe_table_lookup(struct HashLinearProbeTable *table, int key);
void hash_linear_probe_table_destroy(struct HashLinearProbeTable *table);
int hash_linear_probe_verify(void);
double hash_linear_probe_bench(void);

#endif
