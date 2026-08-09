/* runs every sorting family's verify and bench entry points */
#include "registry_sorting.h"
#include "../algos/bubble_sort/bubble_sort.h"
#include "../algos/insertion_sort/insertion_sort.h"
#include "../algos/selection_sort/selection_sort.h"
#include "../algos/shell_sort/shell_sort.h"
#include "../algos/quicksort_lomuto/quicksort_lomuto.h"
#include "../algos/quicksort_hoare/quicksort_hoare.h"
#include "../algos/mergesort_topdown/mergesort_topdown.h"
#include "../algos/mergesort_bottomup/mergesort_bottomup.h"
#include "../algos/heapsort/heapsort.h"
#include "../algos/counting_sort/counting_sort.h"
#include "../algos/radix_sort_lsd/radix_sort_lsd.h"
#include "../algos/radix_sort_msd/radix_sort_msd.h"
#include "../algos/bucket_sort/bucket_sort.h"
#include "../algos/cocktail_sort/cocktail_sort.h"
#include "../algos/gnome_sort/gnome_sort.h"
#include "../algos/comb_sort/comb_sort.h"
#include "../algos/odd_even_sort/odd_even_sort.h"
#include "../algos/pancake_sort/pancake_sort.h"

void registry_run_sorting(int *total, int *passed) {
    (*total)++;
    if (bubble_sort_verify()) {
        (*passed)++;
    }
    bubble_sort_bench();
    (*total)++;
    if (insertion_sort_verify()) {
        (*passed)++;
    }
    insertion_sort_bench();
    (*total)++;
    if (selection_sort_verify()) {
        (*passed)++;
    }
    selection_sort_bench();
    (*total)++;
    if (shell_sort_verify()) {
        (*passed)++;
    }
    shell_sort_bench();
    (*total)++;
    if (quicksort_lomuto_verify()) {
        (*passed)++;
    }
    quicksort_lomuto_bench();
    (*total)++;
    if (quicksort_hoare_verify()) {
        (*passed)++;
    }
    quicksort_hoare_bench();
    (*total)++;
    if (mergesort_topdown_verify()) {
        (*passed)++;
    }
    mergesort_topdown_bench();
    (*total)++;
    if (mergesort_bottomup_verify()) {
        (*passed)++;
    }
    mergesort_bottomup_bench();
    (*total)++;
    if (heapsort_verify()) {
        (*passed)++;
    }
    heapsort_bench();
    (*total)++;
    if (counting_sort_verify()) {
        (*passed)++;
    }
    counting_sort_bench();
    (*total)++;
    if (radix_sort_lsd_verify()) {
        (*passed)++;
    }
    radix_sort_lsd_bench();
    (*total)++;
    if (radix_sort_msd_verify()) {
        (*passed)++;
    }
    radix_sort_msd_bench();
    (*total)++;
    if (bucket_sort_verify()) {
        (*passed)++;
    }
    bucket_sort_bench();
    (*total)++;
    if (cocktail_sort_verify()) {
        (*passed)++;
    }
    cocktail_sort_bench();
    (*total)++;
    if (gnome_sort_verify()) {
        (*passed)++;
    }
    gnome_sort_bench();
    (*total)++;
    if (comb_sort_verify()) {
        (*passed)++;
    }
    comb_sort_bench();
    (*total)++;
    if (odd_even_sort_verify()) {
        (*passed)++;
    }
    odd_even_sort_bench();
    (*total)++;
    if (pancake_sort_verify()) {
        (*passed)++;
    }
    pancake_sort_bench();
}
