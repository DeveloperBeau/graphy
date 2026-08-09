#ifndef ALGOS_TRIE_OPS_H
#define ALGOS_TRIE_OPS_H

struct TrieOpsNode {
    struct TrieOpsNode *children[10];
    int is_end;
};

struct TrieOpsNode *trie_ops_create(void);
void trie_ops_insert(struct TrieOpsNode *root, const char *digits);
int trie_ops_contains(struct TrieOpsNode *root, const char *digits);
void trie_ops_free(struct TrieOpsNode *root);
int trie_ops_verify(void);
double trie_ops_bench(void);

#endif
