#include "checksum_crc8.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void checksum_crc8_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::checksum_crc8_encode(sample);
    std::string decoded = codecs::checksum_crc8_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::checksum_crc8_verify() && decoded == sample;
    core::BenchResult result{"checksum_crc8", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
