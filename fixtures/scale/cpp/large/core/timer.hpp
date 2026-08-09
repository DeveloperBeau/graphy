#pragma once
#include <chrono>

namespace core {

// A tiny stopwatch used to time each codec's encode/decode round trip.
class Timer {
public:
    void timer_start();
    double timer_elapsed_ms() const;

private:
    std::chrono::steady_clock::time_point start_point_;
};

} // namespace core
