#ifndef ALGOS_LINKED_LIST_CYCLE_DETECT_H
#define ALGOS_LINKED_LIST_CYCLE_DETECT_H

struct LinkedListCycleDetectNode {
    int value;
    struct LinkedListCycleDetectNode *next;
};

struct LinkedListCycleDetectNode *linked_list_cycle_detect_build(const int *values, int n);
void linked_list_cycle_detect_make_cycle(struct LinkedListCycleDetectNode *head, int k);
int linked_list_cycle_detect_has_cycle(struct LinkedListCycleDetectNode *head);
void linked_list_cycle_detect_free_linear(struct LinkedListCycleDetectNode *head);
int linked_list_cycle_detect_verify(void);
double linked_list_cycle_detect_bench(void);

#endif
