#include "checksum_luhn.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void checksum_luhn_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_digits(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::checksum_luhn_encode(sample);
    std::string decoded = codecs::checksum_luhn_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::checksum_luhn_verify() && decoded == sample;
    core::BenchResult result{"checksum_luhn", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
