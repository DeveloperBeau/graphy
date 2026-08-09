#include "whitespace_pack.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void whitespace_pack_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::whitespace_pack_encode(sample);
    std::string decoded = codecs::whitespace_pack_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::whitespace_pack_verify() && decoded == sample;
    core::BenchResult result{"whitespace_pack", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
