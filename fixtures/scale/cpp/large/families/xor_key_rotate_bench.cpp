#include "xor_key_rotate.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void xor_key_rotate_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::xor_key_rotate_encode(sample);
    std::string decoded = codecs::xor_key_rotate_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::xor_key_rotate_verify() && decoded == sample;
    core::BenchResult result{"xor_key_rotate", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
