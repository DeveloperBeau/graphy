#include "nibble_swap.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void nibble_swap_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::nibble_swap_encode(sample);
    std::string decoded = codecs::nibble_swap_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::nibble_swap_verify() && decoded == sample;
    core::BenchResult result{"nibble_swap", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
