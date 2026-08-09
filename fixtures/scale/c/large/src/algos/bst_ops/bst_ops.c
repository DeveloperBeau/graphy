/* unbalanced binary search tree insert and lookup */
#include "bst_ops.h"
#include <stdlib.h>

struct BstOpsNode *bst_ops_insert(struct BstOpsNode *root, int value) {
    if (root == NULL) {
        struct BstOpsNode *node = malloc(sizeof(struct BstOpsNode));
        node->value = value;
        node->left = NULL;
        node->right = NULL;
        return node;
    }
    if (value < root->value) {
        root->left = bst_ops_insert(root->left, value);
    } else if (value > root->value) {
        root->right = bst_ops_insert(root->right, value);
    }
    return root;
}

int bst_ops_find(struct BstOpsNode *root, int value) {
    if (root == NULL) {
        return 0;
    }
    if (root->value == value) {
        return 1;
    }
    return value < root->value ? bst_ops_find(root->left, value) : bst_ops_find(root->right, value);
}

void bst_ops_free(struct BstOpsNode *root) {
    if (root == NULL) {
        return;
    }
    bst_ops_free(root->left);
    bst_ops_free(root->right);
    free(root);
}
