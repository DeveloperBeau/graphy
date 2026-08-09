/* xorshift generator used to build repeatable sample data */
#include "rng.h"

unsigned int rng_seed_default(void) {
    return 2463534242u;
}

unsigned int rng_next(unsigned int *state) {
    unsigned int x = *state;
    x ^= x << 13;
    x ^= x >> 17;
    x ^= x << 5;
    *state = x;
    return x;
}
