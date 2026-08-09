#ifndef ALGOS_BST_OPS_H
#define ALGOS_BST_OPS_H

struct BstOpsNode {
    int value;
    struct BstOpsNode *left;
    struct BstOpsNode *right;
};

struct BstOpsNode *bst_ops_insert(struct BstOpsNode *root, int value);
int bst_ops_find(struct BstOpsNode *root, int value);
void bst_ops_free(struct BstOpsNode *root);
int bst_ops_verify(void);
double bst_ops_bench(void);

#endif
