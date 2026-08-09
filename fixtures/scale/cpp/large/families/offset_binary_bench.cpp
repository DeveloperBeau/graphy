#include "offset_binary.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void offset_binary_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::offset_binary_encode(sample);
    std::string decoded = codecs::offset_binary_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::offset_binary_verify() && decoded == sample;
    core::BenchResult result{"offset_binary", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
