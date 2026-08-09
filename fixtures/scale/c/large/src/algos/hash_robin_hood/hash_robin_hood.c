/* open addressing that steals a slot from a richer (closer-to-home) entry */
#include "hash_robin_hood.h"
#include <stdlib.h>

static int hash_robin_hood_hash(int key, int capacity) {
    unsigned int k = (unsigned int)key;
    return (int)(k % (unsigned int)capacity);
}

struct HashRobinHoodTable *hash_robin_hood_table_create(int capacity) {
    struct HashRobinHoodTable *table = malloc(sizeof(struct HashRobinHoodTable));
    table->capacity = capacity;
    table->keys = malloc(sizeof(int) * (size_t)capacity);
    table->values = malloc(sizeof(int) * (size_t)capacity);
    table->dist = calloc((size_t)capacity, sizeof(int));
    table->used = calloc((size_t)capacity, sizeof(int));
    return table;
}

void hash_robin_hood_table_insert(struct HashRobinHoodTable *table, int key, int value) {
    int idx = hash_robin_hood_hash(key, table->capacity);
    int cur_key = key;
    int cur_value = value;
    int cur_dist = 0;
    for (int i = 0; i < table->capacity; i++) {
        int probe = (idx + i) % table->capacity;
        if (!table->used[probe]) {
            table->keys[probe] = cur_key;
            table->values[probe] = cur_value;
            table->dist[probe] = cur_dist;
            table->used[probe] = 1;
            return;
        }
        if (table->keys[probe] == cur_key) {
            table->values[probe] = cur_value;
            return;
        }
        if (table->dist[probe] < cur_dist) {
            int tmp_key = table->keys[probe];
            int tmp_value = table->values[probe];
            int tmp_dist = table->dist[probe];
            table->keys[probe] = cur_key;
            table->values[probe] = cur_value;
            table->dist[probe] = cur_dist;
            cur_key = tmp_key;
            cur_value = tmp_value;
            cur_dist = tmp_dist;
        }
        cur_dist++;
    }
}

int hash_robin_hood_table_lookup(struct HashRobinHoodTable *table, int key) {
    int idx = hash_robin_hood_hash(key, table->capacity);
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

void hash_robin_hood_table_destroy(struct HashRobinHoodTable *table) {
    free(table->keys);
    free(table->values);
    free(table->dist);
    free(table->used);
    free(table);
}
