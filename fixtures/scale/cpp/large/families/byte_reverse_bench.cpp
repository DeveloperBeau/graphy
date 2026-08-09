#include "byte_reverse.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void byte_reverse_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::byte_reverse_encode(sample);
    std::string decoded = codecs::byte_reverse_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::byte_reverse_verify() && decoded == sample;
    core::BenchResult result{"byte_reverse", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
