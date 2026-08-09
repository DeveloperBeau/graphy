#include "xor_diff.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void xor_diff_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::xor_diff_encode(sample);
    std::string decoded = codecs::xor_diff_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::xor_diff_verify() && decoded == sample;
    core::BenchResult result{"xor_diff", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
