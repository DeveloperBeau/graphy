/* open addressing: probes the next slot in sequence on a collision */
#include "hash_linear_probe.h"
#include <stdlib.h>

static int hash_linear_probe_hash(int key, int capacity) {
    unsigned int k = (unsigned int)key;
    return (int)(k % (unsigned int)capacity);
}

struct HashLinearProbeTable *hash_linear_probe_table_create(int capacity) {
    struct HashLinearProbeTable *table = malloc(sizeof(struct HashLinearProbeTable));
    table->capacity = capacity;
    table->keys = malloc(sizeof(int) * (size_t)capacity);
    table->values = malloc(sizeof(int) * (size_t)capacity);
    table->used = calloc((size_t)capacity, sizeof(int));
    return table;
}

void hash_linear_probe_table_insert(struct HashLinearProbeTable *table, int key, int value) {
    int idx = hash_linear_probe_hash(key, table->capacity);
    for (int i = 0; i < table->capacity; i++) {
        int probe = (idx + i) % table->capacity;
        if (!table->used[probe] || table->keys[probe] == key) {
            table->keys[probe] = key;
            table->values[probe] = value;
            table->used[probe] = 1;
            return;
        }
    }
}

int hash_linear_probe_table_lookup(struct HashLinearProbeTable *table, int key) {
    int idx = hash_linear_probe_hash(key, table->capacity);
    for (int i = 0; i < table->capacity; i++) {
        int probe = (idx + i) % table->capacity;
        if (!table->used[probe]) {
            return -1;
        }
        if (table->keys[probe] == key) {
            return table->values[probe];
        }
    }
    return -1;
}

void hash_linear_probe_table_destroy(struct HashLinearProbeTable *table) {
    free(table->keys);
    free(table->values);
    free(table->used);
    free(table);
}
