#ifndef ALGOS_LINKED_LIST_REVERSE_H
#define ALGOS_LINKED_LIST_REVERSE_H

struct LinkedListReverseNode {
    int value;
    struct LinkedListReverseNode *next;
};

struct LinkedListReverseNode *linked_list_reverse_build(const int *values, int n);
struct LinkedListReverseNode *linked_list_reverse_apply(struct LinkedListReverseNode *head);
void linked_list_reverse_free(struct LinkedListReverseNode *head);
int linked_list_reverse_verify(void);
double linked_list_reverse_bench(void);

#endif
