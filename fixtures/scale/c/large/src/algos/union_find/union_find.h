#ifndef ALGOS_UNION_FIND_H
#define ALGOS_UNION_FIND_H

struct UnionFindSet {
    int *parent;
    int *rank;
    int n;
};

struct UnionFindSet *union_find_create(int n);
int union_find_find(struct UnionFindSet *set, int x);
void union_find_union(struct UnionFindSet *set, int a, int b);
int union_find_connected(struct UnionFindSet *set, int a, int b);
void union_find_destroy(struct UnionFindSet *set);
int union_find_verify(void);
double union_find_bench(void);

#endif
