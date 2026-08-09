/* runs every searching family's verify and bench entry points */
#include "registry_searching.h"
#include "../algos/binary_search/binary_search.h"
#include "../algos/interpolation_search/interpolation_search.h"
#include "../algos/exponential_search/exponential_search.h"
#include "../algos/jump_search/jump_search.h"
#include "../algos/fibonacci_search/fibonacci_search.h"
#include "../algos/ternary_search/ternary_search.h"

void registry_run_searching(int *total, int *passed) {
    (*total)++;
    if (binary_search_verify()) {
        (*passed)++;
    }
    binary_search_bench();
    (*total)++;
    if (interpolation_search_verify()) {
        (*passed)++;
    }
    interpolation_search_bench();
    (*total)++;
    if (exponential_search_verify()) {
        (*passed)++;
    }
    exponential_search_bench();
    (*total)++;
    if (jump_search_verify()) {
        (*passed)++;
    }
    jump_search_bench();
    (*total)++;
    if (fibonacci_search_verify()) {
        (*passed)++;
    }
    fibonacci_search_bench();
    (*total)++;
    if (ternary_search_verify()) {
        (*passed)++;
    }
    ternary_search_bench();
}
