/* open addressing: a second hash function sets the probe step size */
#include "hash_double_hash.h"
#include <stdlib.h>

static int hash_double_hash_primary(int key, int capacity) {
    unsigned int k = (unsigned int)key;
    return (int)(k % (unsigned int)capacity);
}

static int hash_double_hash_secondary(int key) {
    unsigned int k = (unsigned int)key;
    int step = (int)(7 - (k % 7));
    return step > 0 ? step : 1;
}

struct HashDoubleHashTable *hash_double_hash_table_create(int capacity) {
    struct HashDoubleHashTable *table = malloc(sizeof(struct HashDoubleHashTable));
    table->capacity = capacity;
    table->keys = malloc(sizeof(int) * (size_t)capacity);
    table->values = malloc(sizeof(int) * (size_t)capacity);
    table->used = calloc((size_t)capacity, sizeof(int));
    return table;
}

void hash_double_hash_table_insert(struct HashDoubleHashTable *table, int key, int value) {
    int idx = hash_double_hash_primary(key, table->capacity);
    int step = hash_double_hash_secondary(key);
    for (int i = 0; i < table->capacity; i++) {
        int probe = (idx + i * step) % table->capacity;
        if (!table->used[probe] || table->keys[probe] == key) {
            table->keys[probe] = key;
            table->values[probe] = value;
            table->used[probe] = 1;
            return;
        }
    }
}

int hash_double_hash_table_lookup(struct HashDoubleHashTable *table, int key) {
    int idx = hash_double_hash_primary(key, table->capacity);
    int step = hash_double_hash_secondary(key);
    for (int i = 0; i < table->capacity; i++) {
        int probe = (idx + i * step) % table->capacity;
        if (table->used[probe] && table->keys[probe] == key) {
            return table->values[probe];
        }
    }
    return -1;
}

void hash_double_hash_table_destroy(struct HashDoubleHashTable *table) {
    free(table->keys);
    free(table->values);
    free(table->used);
    free(table);
}
