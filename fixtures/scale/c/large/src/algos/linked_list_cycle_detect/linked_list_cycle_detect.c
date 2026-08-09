/* Floyd's tortoise-and-hare cycle detection over a singly linked list */
#include "linked_list_cycle_detect.h"
#include <stdlib.h>

struct LinkedListCycleDetectNode *linked_list_cycle_detect_build(const int *values, int n) {
    struct LinkedListCycleDetectNode *head = NULL;
    struct LinkedListCycleDetectNode *tail = NULL;
    for (int i = 0; i < n; i++) {
        struct LinkedListCycleDetectNode *node = malloc(sizeof(struct LinkedListCycleDetectNode));
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

void linked_list_cycle_detect_make_cycle(struct LinkedListCycleDetectNode *head, int k) {
    if (head == NULL) {
        return;
    }
    struct LinkedListCycleDetectNode *target = head;
    for (int i = 0; i < k && target->next != NULL; i++) {
        target = target->next;
    }
    struct LinkedListCycleDetectNode *tail = head;
    while (tail->next != NULL) {
        tail = tail->next;
    }
    tail->next = target;
}

int linked_list_cycle_detect_has_cycle(struct LinkedListCycleDetectNode *head) {
    struct LinkedListCycleDetectNode *slow = head;
    struct LinkedListCycleDetectNode *fast = head;
    while (fast != NULL && fast->next != NULL) {
        slow = slow->next;
        fast = fast->next->next;
        if (slow == fast) {
            return 1;
        }
    }
    return 0;
}

void linked_list_cycle_detect_free_linear(struct LinkedListCycleDetectNode *head) {
    while (head != NULL) {
        struct LinkedListCycleDetectNode *next = head->next;
        free(head);
        head = next;
    }
}
