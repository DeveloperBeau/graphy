#ifndef ALGOS_LINKED_LIST_KTH_FROM_END_H
#define ALGOS_LINKED_LIST_KTH_FROM_END_H

struct LinkedListKthFromEndNode {
    int value;
    struct LinkedListKthFromEndNode *next;
};

struct LinkedListKthFromEndNode *linked_list_kth_from_end_build(const int *values, int n);
int linked_list_kth_from_end_get(struct LinkedListKthFromEndNode *head, int k);
void linked_list_kth_from_end_free(struct LinkedListKthFromEndNode *head);
int linked_list_kth_from_end_verify(void);
double linked_list_kth_from_end_bench(void);

#endif
