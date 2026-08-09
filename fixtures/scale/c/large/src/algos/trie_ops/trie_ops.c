/* ten-way digit trie for prefix-style membership checks */
#include "trie_ops.h"
#include <stdlib.h>

struct TrieOpsNode *trie_ops_create(void) {
    struct TrieOpsNode *node = malloc(sizeof(struct TrieOpsNode));
    for (int i = 0; i < 10; i++) {
        node->children[i] = NULL;
    }
    node->is_end = 0;
    return node;
}

void trie_ops_insert(struct TrieOpsNode *root, const char *digits) {
    struct TrieOpsNode *cur = root;
    for (const char *p = digits; *p != '\0'; p++) {
        int d = *p - '0';
        if (cur->children[d] == NULL) {
            cur->children[d] = trie_ops_create();
        }
        cur = cur->children[d];
    }
    cur->is_end = 1;
}

int trie_ops_contains(struct TrieOpsNode *root, const char *digits) {
    struct TrieOpsNode *cur = root;
    for (const char *p = digits; *p != '\0'; p++) {
        int d = *p - '0';
        if (cur->children[d] == NULL) {
            return 0;
        }
        cur = cur->children[d];
    }
    return cur->is_end;
}

void trie_ops_free(struct TrieOpsNode *root) {
    if (root == NULL) {
        return;
    }
    for (int i = 0; i < 10; i++) {
        trie_ops_free(root->children[i]);
    }
    free(root);
}
