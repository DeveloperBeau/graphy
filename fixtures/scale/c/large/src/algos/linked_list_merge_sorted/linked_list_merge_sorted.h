#ifndef ALGOS_LINKED_LIST_MERGE_SORTED_H
#define ALGOS_LINKED_LIST_MERGE_SORTED_H

struct LinkedListMergeSortedNode {
    int value;
    struct LinkedListMergeSortedNode *next;
};

struct LinkedListMergeSortedNode *linked_list_merge_sorted_build(const int *values, int n);
struct LinkedListMergeSortedNode *linked_list_merge_sorted_merge(
        struct LinkedListMergeSortedNode *a, struct LinkedListMergeSortedNode *b);
void linked_list_merge_sorted_free(struct LinkedListMergeSortedNode *head);
int linked_list_merge_sorted_verify(void);
double linked_list_merge_sorted_bench(void);

#endif
