#include "backslash_escape.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void backslash_escape_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::backslash_escape_encode(sample);
    std::string decoded = codecs::backslash_escape_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::backslash_escape_verify() && decoded == sample;
    core::BenchResult result{"backslash_escape", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
