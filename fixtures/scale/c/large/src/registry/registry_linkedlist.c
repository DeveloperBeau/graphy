/* runs every linkedlist family's verify and bench entry points */
#include "registry_linkedlist.h"
#include "../algos/linked_list_reverse/linked_list_reverse.h"
#include "../algos/linked_list_cycle_detect/linked_list_cycle_detect.h"
#include "../algos/linked_list_merge_sorted/linked_list_merge_sorted.h"
#include "../algos/linked_list_dedup/linked_list_dedup.h"
#include "../algos/linked_list_kth_from_end/linked_list_kth_from_end.h"
#include "../algos/linked_list_rotate/linked_list_rotate.h"

void registry_run_linkedlist(int *total, int *passed) {
    (*total)++;
    if (linked_list_reverse_verify()) {
        (*passed)++;
    }
    linked_list_reverse_bench();
    (*total)++;
    if (linked_list_cycle_detect_verify()) {
        (*passed)++;
    }
    linked_list_cycle_detect_bench();
    (*total)++;
    if (linked_list_merge_sorted_verify()) {
        (*passed)++;
    }
    linked_list_merge_sorted_bench();
    (*total)++;
    if (linked_list_dedup_verify()) {
        (*passed)++;
    }
    linked_list_dedup_bench();
    (*total)++;
    if (linked_list_kth_from_end_verify()) {
        (*passed)++;
    }
    linked_list_kth_from_end_bench();
    (*total)++;
    if (linked_list_rotate_verify()) {
        (*passed)++;
    }
    linked_list_rotate_bench();
}
