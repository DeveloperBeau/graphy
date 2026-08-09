#include "checksum_fletcher.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void checksum_fletcher_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::checksum_fletcher_encode(sample);
    std::string decoded = codecs::checksum_fletcher_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::checksum_fletcher_verify() && decoded == sample;
    core::BenchResult result{"checksum_fletcher", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
