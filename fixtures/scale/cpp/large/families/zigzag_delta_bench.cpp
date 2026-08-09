#include "zigzag_delta.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void zigzag_delta_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::zigzag_delta_encode(sample);
    std::string decoded = codecs::zigzag_delta_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::zigzag_delta_verify() && decoded == sample;
    core::BenchResult result{"zigzag_delta", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
