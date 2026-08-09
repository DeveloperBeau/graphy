#ifndef ALGOS_LINKED_LIST_DEDUP_H
#define ALGOS_LINKED_LIST_DEDUP_H

struct LinkedListDedupNode {
    int value;
    struct LinkedListDedupNode *next;
};

struct LinkedListDedupNode *linked_list_dedup_build(const int *values, int n);
int linked_list_dedup_apply(struct LinkedListDedupNode *head);
void linked_list_dedup_free(struct LinkedListDedupNode *head);
int linked_list_dedup_verify(void);
double linked_list_dedup_bench(void);

#endif
