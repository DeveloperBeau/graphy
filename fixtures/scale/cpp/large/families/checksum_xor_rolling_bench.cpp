#include "checksum_xor_rolling.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void checksum_xor_rolling_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::checksum_xor_rolling_encode(sample);
    std::string decoded = codecs::checksum_xor_rolling_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::checksum_xor_rolling_verify() && decoded == sample;
    core::BenchResult result{"checksum_xor_rolling", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
