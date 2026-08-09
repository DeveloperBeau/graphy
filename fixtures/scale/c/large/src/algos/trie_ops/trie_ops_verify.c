#include "trie_ops.h"

int trie_ops_verify(void) {
    struct TrieOpsNode *root = trie_ops_create();
    trie_ops_insert(root, "123");
    trie_ops_insert(root, "456");
    int ok = trie_ops_contains(root, "123") && !trie_ops_contains(root, "789");
    trie_ops_free(root);
    return ok;
}
