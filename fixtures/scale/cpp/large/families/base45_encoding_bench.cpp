#include "base45_encoding.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void base45_encoding_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::base45_encoding_encode(sample);
    std::string decoded = codecs::base45_encoding_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::base45_encoding_verify() && decoded == sample;
    core::BenchResult result{"base45_encoding", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
