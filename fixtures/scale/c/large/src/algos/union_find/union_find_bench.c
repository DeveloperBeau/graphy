#include "union_find.h"
#include "../../core/timer.h"
#include "../../core/report.h"

double union_find_bench(void) {
    int n = 512;
    double start = timer_now_ms();
    struct UnionFindSet *set = union_find_create(n);
    for (int i = 0; i < n - 1; i++) {
        union_find_union(set, i, i + 1);
    }
    int ok = union_find_connected(set, 0, n - 1);
    double elapsed = timer_elapsed_ms(start);
    report_print_line("union_find", elapsed, ok);
    union_find_destroy(set);
    return elapsed;
}
