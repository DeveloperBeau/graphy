#include "linked_list_rotate.h"
#include "../../core/sample.h"
#include "../../core/report.h"

int linked_list_rotate_verify(void) {
    int n = 10;
    int *values = sample_make_ints(n, 1701u);
    struct LinkedListRotateNode *head = linked_list_rotate_build(values, n);
    int k = 3;
    head = linked_list_rotate_apply(head, k);
    int ok = report_check_eq(head->value, values[k]);
    linked_list_rotate_free(head);
    sample_free_ints(values);
    return ok;
}
