/* splices two already-sorted linked lists into one sorted list */
#include "linked_list_merge_sorted.h"
#include <stdlib.h>

struct LinkedListMergeSortedNode *linked_list_merge_sorted_build(const int *values, int n) {
    struct LinkedListMergeSortedNode *head = NULL;
    struct LinkedListMergeSortedNode *tail = NULL;
    for (int i = 0; i < n; i++) {
        struct LinkedListMergeSortedNode *node = malloc(sizeof(struct LinkedListMergeSortedNode));
        node->value = values[i];
        node->next = NULL;
        if (head == NULL) {
            head = node;
        } else {
            tail->next = node;
        }
        tail = node;
    }
    return head;
}

struct LinkedListMergeSortedNode *linked_list_merge_sorted_merge(
        struct LinkedListMergeSortedNode *a, struct LinkedListMergeSortedNode *b) {
    struct LinkedListMergeSortedNode dummy;
    struct LinkedListMergeSortedNode *tail = &dummy;
    dummy.next = NULL;
    while (a != NULL && b != NULL) {
        if (a->value <= b->value) {
            tail->next = a;
            a = a->next;
        } else {
            tail->next = b;
            b = b->next;
        }
        tail = tail->next;
    }
    tail->next = (a != NULL) ? a : b;
    return dummy.next;
}

void linked_list_merge_sorted_free(struct LinkedListMergeSortedNode *head) {
    while (head != NULL) {
        struct LinkedListMergeSortedNode *next = head->next;
        free(head);
        head = next;
    }
}
