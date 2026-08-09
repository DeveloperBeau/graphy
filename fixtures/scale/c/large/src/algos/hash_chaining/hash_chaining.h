#ifndef ALGOS_HASH_CHAINING_H
#define ALGOS_HASH_CHAINING_H

struct HashChainingNode {
    int key;
    int value;
    struct HashChainingNode *next;
};

struct HashChainingTable {
    struct HashChainingNode **buckets;
    int capacity;
};

struct HashChainingTable *hash_chaining_table_create(int capacity);
void hash_chaining_table_insert(struct HashChainingTable *table, int key, int value);
int hash_chaining_table_lookup(struct HashChainingTable *table, int key);
void hash_chaining_table_destroy(struct HashChainingTable *table);
int hash_chaining_verify(void);
double hash_chaining_bench(void);

#endif
