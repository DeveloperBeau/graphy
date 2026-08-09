#include "linked_list_cycle_detect.h"
#include "../../core/sample.h"
#include <stddef.h>

int linked_list_cycle_detect_verify(void) {
    int n = 10;
    int *values = sample_make_ints(n, 1301u);
    struct LinkedListCycleDetectNode *head = linked_list_cycle_detect_build(values, n);
    linked_list_cycle_detect_make_cycle(head, 3);
    int ok = linked_list_cycle_detect_has_cycle(head);
    struct LinkedListCycleDetectNode *cur = head;
    for (int i = 0; i < n - 1; i++) {
        cur = cur->next;
    }
    cur->next = NULL;
    linked_list_cycle_detect_free_linear(head);
    sample_free_ints(values);
    return ok;
}
