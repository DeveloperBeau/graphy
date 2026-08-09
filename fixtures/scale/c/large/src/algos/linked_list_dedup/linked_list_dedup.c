/* removes adjacent duplicate values from an already-sorted linked list */
#include "linked_list_dedup.h"
#include <stdlib.h>

struct LinkedListDedupNode *linked_list_dedup_build(const int *values, int n) {
    struct LinkedListDedupNode *head = NULL;
    struct LinkedListDedupNode *tail = NULL;
    for (int i = 0; i < n; i++) {
        struct LinkedListDedupNode *node = malloc(sizeof(struct LinkedListDedupNode));
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

int linked_list_dedup_apply(struct LinkedListDedupNode *head) {
    int removed = 0;
    struct LinkedListDedupNode *cur = head;
    while (cur != NULL && cur->next != NULL) {
        if (cur->value == cur->next->value) {
            struct LinkedListDedupNode *dup = cur->next;
            cur->next = dup->next;
            free(dup);
            removed++;
        } else {
            cur = cur->next;
        }
    }
    return removed;
}

void linked_list_dedup_free(struct LinkedListDedupNode *head) {
    while (head != NULL) {
        struct LinkedListDedupNode *next = head->next;
        free(head);
        head = next;
    }
}
