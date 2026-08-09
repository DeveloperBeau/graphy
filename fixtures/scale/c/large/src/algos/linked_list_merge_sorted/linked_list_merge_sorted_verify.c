#include "linked_list_merge_sorted.h"
#include "../../core/sample.h"
#include <stddef.h>

static int linked_list_merge_sorted_is_sorted(struct LinkedListMergeSortedNode *head) {
    while (head != NULL && head->next != NULL) {
        if (head->value > head->next->value) {
            return 0;
        }
        head = head->next;
    }
    return 1;
}

int linked_list_merge_sorted_verify(void) {
    int n = 12;
    int *a_vals = sample_make_ints(n, 1401u);
    int *b_vals = sample_make_ints(n, 1402u);
    sample_sort_ints(a_vals, n);
    sample_sort_ints(b_vals, n);
    struct LinkedListMergeSortedNode *a = linked_list_merge_sorted_build(a_vals, n);
    struct LinkedListMergeSortedNode *b = linked_list_merge_sorted_build(b_vals, n);
    struct LinkedListMergeSortedNode *merged = linked_list_merge_sorted_merge(a, b);
    int ok = linked_list_merge_sorted_is_sorted(merged);
    linked_list_merge_sorted_free(merged);
    sample_free_ints(a_vals);
    sample_free_ints(b_vals);
    return ok;
}
