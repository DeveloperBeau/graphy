#include "linked_list_kth_from_end.h"
#include "../../core/sample.h"
#include "../../core/report.h"

int linked_list_kth_from_end_verify(void) {
    int n = 10;
    int *values = sample_make_ints(n, 1601u);
    struct LinkedListKthFromEndNode *head = linked_list_kth_from_end_build(values, n);
    int k = 2;
    int found = linked_list_kth_from_end_get(head, k);
    int ok = report_check_eq(found, values[n - 1 - k]);
    linked_list_kth_from_end_free(head);
    sample_free_ints(values);
    return ok;
}
