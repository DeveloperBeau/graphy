/* two tables and two hash functions; a bumped entry hops to its other home */
#include "hash_cuckoo.h"
#include <stdlib.h>

static int hash_cuckoo_hash1(int key, int capacity) {
    unsigned int k = (unsigned int)key;
    return (int)(k % (unsigned int)capacity);
}

static int hash_cuckoo_hash2(int key, int capacity) {
    unsigned int k = (unsigned int)key * 2654435761u;
    return (int)(k % (unsigned int)capacity);
}

struct HashCuckooTable *hash_cuckoo_table_create(int capacity) {
    struct HashCuckooTable *table = malloc(sizeof(struct HashCuckooTable));
    table->capacity = capacity;
    table->keys1 = malloc(sizeof(int) * (size_t)capacity);
    table->values1 = malloc(sizeof(int) * (size_t)capacity);
    table->used1 = calloc((size_t)capacity, sizeof(int));
    table->keys2 = malloc(sizeof(int) * (size_t)capacity);
    table->values2 = malloc(sizeof(int) * (size_t)capacity);
    table->used2 = calloc((size_t)capacity, sizeof(int));
    return table;
}

void hash_cuckoo_table_insert(struct HashCuckooTable *table, int key, int value) {
    int cur_key = key;
    int cur_value = value;
    for (int kicks = 0; kicks < table->capacity; kicks++) {
        int idx1 = hash_cuckoo_hash1(cur_key, table->capacity);
        if (!table->used1[idx1]) {
            table->keys1[idx1] = cur_key;
            table->values1[idx1] = cur_value;
            table->used1[idx1] = 1;
            return;
        }
        if (table->keys1[idx1] == cur_key) {
            table->values1[idx1] = cur_value;
            return;
        }
        int tmp_key = table->keys1[idx1];
        int tmp_value = table->values1[idx1];
        table->keys1[idx1] = cur_key;
        table->values1[idx1] = cur_value;
        cur_key = tmp_key;
        cur_value = tmp_value;

        int idx2 = hash_cuckoo_hash2(cur_key, table->capacity);
        if (!table->used2[idx2]) {
            table->keys2[idx2] = cur_key;
            table->values2[idx2] = cur_value;
            table->used2[idx2] = 1;
            return;
        }
        if (table->keys2[idx2] == cur_key) {
            table->values2[idx2] = cur_value;
            return;
        }
        tmp_key = table->keys2[idx2];
        tmp_value = table->values2[idx2];
        table->keys2[idx2] = cur_key;
        table->values2[idx2] = cur_value;
        cur_key = tmp_key;
        cur_value = tmp_value;
    }
}

int hash_cuckoo_table_lookup(struct HashCuckooTable *table, int key) {
    int idx1 = hash_cuckoo_hash1(key, table->capacity);
    if (table->used1[idx1] && table->keys1[idx1] == key) {
        return table->values1[idx1];
    }
    int idx2 = hash_cuckoo_hash2(key, table->capacity);
    if (table->used2[idx2] && table->keys2[idx2] == key) {
        return table->values2[idx2];
    }
    return -1;
}

void hash_cuckoo_table_destroy(struct HashCuckooTable *table) {
    free(table->keys1);
    free(table->values1);
    free(table->used1);
    free(table->keys2);
    free(table->values2);
    free(table->used2);
    free(table);
}
