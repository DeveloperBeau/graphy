#include "trie_ops.h"
#include "../../core/timer.h"
#include "../../core/report.h"
#include <stdio.h>

double trie_ops_bench(void) {
    double start = timer_now_ms();
    struct TrieOpsNode *root = trie_ops_create();
    char buf[8];
    for (int i = 0; i < 200; i++) {
        snprintf(buf, sizeof(buf), "%d", i);
        trie_ops_insert(root, buf);
    }
    int ok = trie_ops_contains(root, "100");
    double elapsed = timer_elapsed_ms(start);
    report_print_line("trie_ops", elapsed, ok);
    trie_ops_free(root);
    return elapsed;
}
