#include "base64_custom.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void base64_custom_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::base64_custom_encode(sample);
    std::string decoded = codecs::base64_custom_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::base64_custom_verify() && decoded == sample;
    core::BenchResult result{"base64_custom", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
