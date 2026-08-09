#include "linked_list_dedup.h"
#include "../../core/sample.h"
#include <stddef.h>

int linked_list_dedup_verify(void) {
    int n = 20;
    int *values = sample_make_ints(n, 1501u);
    for (int i = 0; i < n; i++) {
        values[i] = values[i] % 5;
    }
    sample_sort_ints(values, n);
    struct LinkedListDedupNode *head = linked_list_dedup_build(values, n);
    linked_list_dedup_apply(head);
    int prev = -1;
    int unique_count = 0;
    int ok = 1;
    struct LinkedListDedupNode *cur = head;
    while (cur != NULL) {
        if (cur->value == prev) {
            ok = 0;
        }
        prev = cur->value;
        unique_count++;
        cur = cur->next;
    }
    linked_list_dedup_free(head);
    sample_free_ints(values);
    return ok && unique_count <= 5;
}
