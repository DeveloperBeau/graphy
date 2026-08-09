#ifndef ALGOS_LINKED_LIST_ROTATE_H
#define ALGOS_LINKED_LIST_ROTATE_H

struct LinkedListRotateNode {
    int value;
    struct LinkedListRotateNode *next;
};

struct LinkedListRotateNode *linked_list_rotate_build(const int *values, int n);
struct LinkedListRotateNode *linked_list_rotate_apply(struct LinkedListRotateNode *head, int k);
void linked_list_rotate_free(struct LinkedListRotateNode *head);
int linked_list_rotate_verify(void);
double linked_list_rotate_bench(void);

#endif
