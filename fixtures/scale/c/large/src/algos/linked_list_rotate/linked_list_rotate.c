/* rotates a singly linked list left by k positions in one pass */
#include "linked_list_rotate.h"
#include <stdlib.h>

struct LinkedListRotateNode *linked_list_rotate_build(const int *values, int n) {
    struct LinkedListRotateNode *head = NULL;
    struct LinkedListRotateNode *tail = NULL;
    for (int i = 0; i < n; i++) {
        struct LinkedListRotateNode *node = malloc(sizeof(struct LinkedListRotateNode));
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

struct LinkedListRotateNode *linked_list_rotate_apply(struct LinkedListRotateNode *head, int k) {
    if (head == NULL) {
        return NULL;
    }
    int len = 1;
    struct LinkedListRotateNode *tail = head;
    while (tail->next != NULL) {
        tail = tail->next;
        len++;
    }
    int shift = k % len;
    if (shift == 0) {
        return head;
    }
    struct LinkedListRotateNode *new_tail = head;
    for (int i = 0; i < len - shift - 1; i++) {
        new_tail = new_tail->next;
    }
    struct LinkedListRotateNode *new_head = new_tail->next;
    new_tail->next = NULL;
    tail->next = head;
    return new_head;
}

void linked_list_rotate_free(struct LinkedListRotateNode *head) {
    while (head != NULL) {
        struct LinkedListRotateNode *next = head->next;
        free(head);
        head = next;
    }
}
