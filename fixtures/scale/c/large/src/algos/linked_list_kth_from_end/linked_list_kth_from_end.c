/* two-pointer technique: advance a lead pointer k steps, then walk both */
#include "linked_list_kth_from_end.h"
#include <stdlib.h>

struct LinkedListKthFromEndNode *linked_list_kth_from_end_build(const int *values, int n) {
    struct LinkedListKthFromEndNode *head = NULL;
    struct LinkedListKthFromEndNode *tail = NULL;
    for (int i = 0; i < n; i++) {
        struct LinkedListKthFromEndNode *node = malloc(sizeof(struct LinkedListKthFromEndNode));
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

int linked_list_kth_from_end_get(struct LinkedListKthFromEndNode *head, int k) {
    struct LinkedListKthFromEndNode *lead = head;
    for (int i = 0; i < k; i++) {
        if (lead == NULL) {
            return -1;
        }
        lead = lead->next;
    }
    struct LinkedListKthFromEndNode *trail = head;
    while (lead != NULL) {
        lead = lead->next;
        trail = trail->next;
    }
    return trail != NULL ? trail->value : -1;
}

void linked_list_kth_from_end_free(struct LinkedListKthFromEndNode *head) {
    while (head != NULL) {
        struct LinkedListKthFromEndNode *next = head->next;
        free(head);
        head = next;
    }
}
