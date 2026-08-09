#include "lz_window.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void lz_window_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::lz_window_encode(sample);
    std::string decoded = codecs::lz_window_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::lz_window_verify() && decoded == sample;
    core::BenchResult result{"lz_window", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
