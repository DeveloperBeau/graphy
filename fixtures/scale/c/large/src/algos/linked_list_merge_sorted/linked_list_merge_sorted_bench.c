#include "linked_list_merge_sorted.h"
#include "../../core/sample.h"
#include "../../core/timer.h"
#include "../../core/report.h"
#include <stddef.h>

double linked_list_merge_sorted_bench(void) {
    int n = 256;
    int *a_vals = sample_make_ints(n, 1403u);
    int *b_vals = sample_make_ints(n, 1404u);
    sample_sort_ints(a_vals, n);
    sample_sort_ints(b_vals, n);
    double start = timer_now_ms();
    struct LinkedListMergeSortedNode *a = linked_list_merge_sorted_build(a_vals, n);
    struct LinkedListMergeSortedNode *b = linked_list_merge_sorted_build(b_vals, n);
    struct LinkedListMergeSortedNode *merged = linked_list_merge_sorted_merge(a, b);
    double elapsed = timer_elapsed_ms(start);
    report_print_line("linked_list_merge_sorted", elapsed, merged != NULL);
    linked_list_merge_sorted_free(merged);
    sample_free_ints(a_vals);
    sample_free_ints(b_vals);
    return elapsed;
}
