#include "linked_list_kth_from_end.h"
#include "../../core/sample.h"
#include "../../core/timer.h"
#include "../../core/report.h"

double linked_list_kth_from_end_bench(void) {
    int n = 256;
    int *values = sample_make_ints(n, 1602u);
    double start = timer_now_ms();
    struct LinkedListKthFromEndNode *head = linked_list_kth_from_end_build(values, n);
    int found = linked_list_kth_from_end_get(head, 5);
    double elapsed = timer_elapsed_ms(start);
    report_print_line("linked_list_kth_from_end", elapsed, found >= 0);
    linked_list_kth_from_end_free(head);
    sample_free_ints(values);
    return elapsed;
}
