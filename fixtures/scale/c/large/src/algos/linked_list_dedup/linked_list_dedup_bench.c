#include "linked_list_dedup.h"
#include "../../core/sample.h"
#include "../../core/timer.h"
#include "../../core/report.h"

double linked_list_dedup_bench(void) {
    int n = 256;
    int *values = sample_make_ints(n, 1502u);
    for (int i = 0; i < n; i++) {
        values[i] = values[i] % 40;
    }
    sample_sort_ints(values, n);
    double start = timer_now_ms();
    struct LinkedListDedupNode *head = linked_list_dedup_build(values, n);
    linked_list_dedup_apply(head);
    double elapsed = timer_elapsed_ms(start);
    report_print_line("linked_list_dedup", elapsed, 1);
    linked_list_dedup_free(head);
    sample_free_ints(values);
    return elapsed;
}
