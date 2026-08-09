/* open addressing: probe offsets grow with the square of the attempt */
#include "hash_quadratic_probe.h"
#include <stdlib.h>

static int hash_quadratic_probe_hash(int key, int capacity) {
    unsigned int k = (unsigned int)key;
    return (int)(k % (unsigned int)capacity);
}

struct HashQuadraticProbeTable *hash_quadratic_probe_table_create(int capacity) {
    struct HashQuadraticProbeTable *table = malloc(sizeof(struct HashQuadraticProbeTable));
    table->capacity = capacity;
    table->keys = malloc(sizeof(int) * (size_t)capacity);
    table->values = malloc(sizeof(int) * (size_t)capacity);
    table->used = calloc((size_t)capacity, sizeof(int));
    return table;
}

void hash_quadratic_probe_table_insert(struct HashQuadraticProbeTable *table, int key, int value) {
    int base = hash_quadratic_probe_hash(key, table->capacity);
    for (int i = 0; i < table->capacity; i++) {
        int idx = (base + i * i) % table->capacity;
        if (!table->used[idx] || table->keys[idx] == key) {
            table->keys[idx] = key;
            table->values[idx] = value;
            table->used[idx] = 1;
            return;
        }
    }
}

int hash_quadratic_probe_table_lookup(struct HashQuadraticProbeTable *table, int key) {
    int base = hash_quadratic_probe_hash(key, table->capacity);
    for (int i = 0; i < table->capacity; i++) {
        int idx = (base + i * i) % table->capacity;
        if (table->used[idx] && table->keys[idx] == key) {
            return table->values[idx];
        }
    }
    return -1;
}

void hash_quadratic_probe_table_destroy(struct HashQuadraticProbeTable *table) {
    free(table->keys);
    free(table->values);
    free(table->used);
    free(table);
}
