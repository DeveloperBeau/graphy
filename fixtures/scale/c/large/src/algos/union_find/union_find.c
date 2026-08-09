/* disjoint-set forest with path compression and union by rank */
#include "union_find.h"
#include <stdlib.h>

struct UnionFindSet *union_find_create(int n) {
    struct UnionFindSet *set = malloc(sizeof(struct UnionFindSet));
    set->parent = malloc(sizeof(int) * (size_t)n);
    set->rank = calloc((size_t)n, sizeof(int));
    set->n = n;
    for (int i = 0; i < n; i++) {
        set->parent[i] = i;
    }
    return set;
}

int union_find_find(struct UnionFindSet *set, int x) {
    if (set->parent[x] != x) {
        set->parent[x] = union_find_find(set, set->parent[x]);
    }
    return set->parent[x];
}

void union_find_union(struct UnionFindSet *set, int a, int b) {
    int ra = union_find_find(set, a);
    int rb = union_find_find(set, b);
    if (ra == rb) {
        return;
    }
    if (set->rank[ra] < set->rank[rb]) {
        set->parent[ra] = rb;
    } else if (set->rank[ra] > set->rank[rb]) {
        set->parent[rb] = ra;
    } else {
        set->parent[rb] = ra;
        set->rank[ra]++;
    }
}

int union_find_connected(struct UnionFindSet *set, int a, int b) {
    return union_find_find(set, a) == union_find_find(set, b);
}

void union_find_destroy(struct UnionFindSet *set) {
    free(set->parent);
    free(set->rank);
    free(set);
}
