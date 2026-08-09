#include "header_length_prefix_codec.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void header_length_prefix_codec_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::header_length_prefix_codec_encode(sample);
    std::string decoded = codecs::header_length_prefix_codec_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::header_length_prefix_codec_verify() && decoded == sample;
    core::BenchResult result{"header_length_prefix_codec", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
