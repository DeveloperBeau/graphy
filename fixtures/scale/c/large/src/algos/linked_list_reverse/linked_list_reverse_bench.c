#include "linked_list_reverse.h"
#include "../../core/sample.h"
#include "../../core/timer.h"
#include "../../core/report.h"
#include <stddef.h>

double linked_list_reverse_bench(void) {
    int n = 256;
    int *values = sample_make_ints(n, 1202u);
    double start = timer_now_ms();
    struct LinkedListReverseNode *head = linked_list_reverse_build(values, n);
    head = linked_list_reverse_apply(head);
    double elapsed = timer_elapsed_ms(start);
    report_print_line("linked_list_reverse", elapsed, head != NULL);
    linked_list_reverse_free(head);
    sample_free_ints(values);
    return elapsed;
}
