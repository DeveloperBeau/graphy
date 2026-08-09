#include "linked_list_reverse.h"
#include "../../core/sample.h"
#include "../../core/report.h"
#include <stddef.h>

int linked_list_reverse_verify(void) {
    int n = 10;
    int *values = sample_make_ints(n, 1201u);
    struct LinkedListReverseNode *head = linked_list_reverse_build(values, n);
    head = linked_list_reverse_apply(head);
    int ok = 1;
    struct LinkedListReverseNode *cur = head;
    for (int i = n - 1; i >= 0 && cur != NULL; i--) {
        ok = ok && report_check_eq(cur->value, values[i]);
        cur = cur->next;
    }
    linked_list_reverse_free(head);
    sample_free_ints(values);
    return ok;
}
