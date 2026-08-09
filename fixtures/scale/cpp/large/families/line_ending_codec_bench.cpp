#include "line_ending_codec.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void line_ending_codec_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::line_ending_codec_encode(sample);
    std::string decoded = codecs::line_ending_codec_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::line_ending_codec_verify() && decoded == sample;
    core::BenchResult result{"line_ending_codec", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
