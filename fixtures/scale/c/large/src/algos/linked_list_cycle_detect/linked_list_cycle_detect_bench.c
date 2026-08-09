#include "linked_list_cycle_detect.h"
#include "../../core/sample.h"
#include "../../core/timer.h"
#include "../../core/report.h"

double linked_list_cycle_detect_bench(void) {
    int n = 256;
    int *values = sample_make_ints(n, 1302u);
    double start = timer_now_ms();
    struct LinkedListCycleDetectNode *head = linked_list_cycle_detect_build(values, n);
    int has_cycle = linked_list_cycle_detect_has_cycle(head);
    double elapsed = timer_elapsed_ms(start);
    report_print_line("linked_list_cycle_detect", elapsed, !has_cycle);
    linked_list_cycle_detect_free_linear(head);
    sample_free_ints(values);
    return elapsed;
}
