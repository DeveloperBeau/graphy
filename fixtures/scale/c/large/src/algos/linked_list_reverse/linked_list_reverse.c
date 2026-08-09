/* reverses a singly linked list by walking it once with three pointers */
#include "linked_list_reverse.h"
#include <stdlib.h>

struct LinkedListReverseNode *linked_list_reverse_build(const int *values, int n) {
    struct LinkedListReverseNode *head = NULL;
    for (int i = n - 1; i >= 0; i--) {
        struct LinkedListReverseNode *node = malloc(sizeof(struct LinkedListReverseNode));
        node->value = values[i];
        node->next = head;
        head = node;
    }
    return head;
}

struct LinkedListReverseNode *linked_list_reverse_apply(struct LinkedListReverseNode *head) {
    struct LinkedListReverseNode *prev = NULL;
    struct LinkedListReverseNode *cur = head;
    while (cur != NULL) {
        struct LinkedListReverseNode *next = cur->next;
        cur->next = prev;
        prev = cur;
        cur = next;
    }
    return prev;
}

void linked_list_reverse_free(struct LinkedListReverseNode *head) {
    while (head != NULL) {
        struct LinkedListReverseNode *next = head->next;
        free(head);
        head = next;
    }
}
