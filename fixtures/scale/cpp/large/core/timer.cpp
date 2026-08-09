#include "timer.hpp"

namespace core {

void Timer::timer_start() {
    start_point_ = std::chrono::steady_clock::now();
}

double Timer::timer_elapsed_ms() const {
    auto now = std::chrono::steady_clock::now();
    std::chrono::duration<double, std::milli> elapsed = now - start_point_;
    return elapsed.count();
}

} // namespace core
