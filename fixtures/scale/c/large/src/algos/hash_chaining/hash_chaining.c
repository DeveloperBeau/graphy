/* separate chaining: each bucket holds a linked list of collisions */
#include "hash_chaining.h"
#include <stdlib.h>

static int hash_chaining_hash(int key, int capacity) {
    unsigned int k = (unsigned int)key;
    return (int)(k % (unsigned int)capacity);
}

struct HashChainingTable *hash_chaining_table_create(int capacity) {
    struct HashChainingTable *table = malloc(sizeof(struct HashChainingTable));
    table->capacity = capacity;
    table->buckets = calloc((size_t)capacity, sizeof(struct HashChainingNode *));
    return table;
}

void hash_chaining_table_insert(struct HashChainingTable *table, int key, int value) {
    int idx = hash_chaining_hash(key, table->capacity);
    struct HashChainingNode *node = malloc(sizeof(struct HashChainingNode));
    node->key = key;
    node->value = value;
    node->next = table->buckets[idx];
    table->buckets[idx] = node;
}

int hash_chaining_table_lookup(struct HashChainingTable *table, int key) {
    int idx = hash_chaining_hash(key, table->capacity);
    struct HashChainingNode *cur = table->buckets[idx];
    while (cur != NULL) {
        if (cur->key == key) {
            return cur->value;
        }
        cur = cur->next;
    }
    return -1;
}

void hash_chaining_table_destroy(struct HashChainingTable *table) {
    for (int i = 0; i < table->capacity; i++) {
        struct HashChainingNode *cur = table->buckets[i];
        while (cur != NULL) {
            struct HashChainingNode *next = cur->next;
            free(cur);
            cur = next;
        }
    }
    free(table->buckets);
    free(table);
}
