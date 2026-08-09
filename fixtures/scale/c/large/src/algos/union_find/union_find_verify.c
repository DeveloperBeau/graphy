#include "union_find.h"

int union_find_verify(void) {
    struct UnionFindSet *set = union_find_create(10);
    union_find_union(set, 1, 2);
    union_find_union(set, 2, 3);
    int ok = union_find_connected(set, 1, 3) && !union_find_connected(set, 1, 5);
    union_find_destroy(set);
    return ok;
}
