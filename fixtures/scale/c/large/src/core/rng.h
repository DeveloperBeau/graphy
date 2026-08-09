#ifndef CORE_RNG_H
#define CORE_RNG_H

unsigned int rng_seed_default(void);
unsigned int rng_next(unsigned int *state);

#endif
