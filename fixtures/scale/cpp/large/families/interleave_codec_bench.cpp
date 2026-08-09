#include "interleave_codec.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void interleave_codec_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::interleave_codec_encode(sample);
    std::string decoded = codecs::interleave_codec_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::interleave_codec_verify() && decoded == sample;
    core::BenchResult result{"interleave_codec", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
