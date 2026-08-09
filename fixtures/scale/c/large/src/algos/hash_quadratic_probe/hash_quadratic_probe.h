#ifndef ALGOS_HASH_QUADRATIC_PROBE_H
#define ALGOS_HASH_QUADRATIC_PROBE_H

struct HashQuadraticProbeTable {
    int *keys;
    int *values;
    int *used;
    int capacity;
};

struct HashQuadraticProbeTable *hash_quadratic_probe_table_create(int capacity);
void hash_quadratic_probe_table_insert(struct HashQuadraticProbeTable *table, int key, int value);
int hash_quadratic_probe_table_lookup(struct HashQuadraticProbeTable *table, int key);
void hash_quadratic_probe_table_destroy(struct HashQuadraticProbeTable *table);
int hash_quadratic_probe_verify(void);
double hash_quadratic_probe_bench(void);

#endif
