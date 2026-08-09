/* monotonic millisecond clock used to time each algorithm */
#include "timer.h"
#include <time.h>

double timer_now_ms(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (double)ts.tv_sec * 1000.0 + (double)ts.tv_nsec / 1e6;
}

double timer_elapsed_ms(double start_ms) {
    return timer_now_ms() - start_ms;
}
