#include "bitmap_rle.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void bitmap_rle_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_bitstring(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::bitmap_rle_encode(sample);
    std::string decoded = codecs::bitmap_rle_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::bitmap_rle_verify() && decoded == sample;
    core::BenchResult result{"bitmap_rle", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
