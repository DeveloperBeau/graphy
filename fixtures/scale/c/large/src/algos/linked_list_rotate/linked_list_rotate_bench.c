#include "linked_list_rotate.h"
#include "../../core/sample.h"
#include "../../core/timer.h"
#include "../../core/report.h"
#include <stddef.h>

double linked_list_rotate_bench(void) {
    int n = 256;
    int *values = sample_make_ints(n, 1702u);
    double start = timer_now_ms();
    struct LinkedListRotateNode *head = linked_list_rotate_build(values, n);
    head = linked_list_rotate_apply(head, 17);
    double elapsed = timer_elapsed_ms(start);
    report_print_line("linked_list_rotate", elapsed, head != NULL);
    linked_list_rotate_free(head);
    sample_free_ints(values);
    return elapsed;
}
