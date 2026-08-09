#include "atbash.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void atbash_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::atbash_encode(sample);
    std::string decoded = codecs::atbash_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::atbash_verify() && decoded == sample;
    core::BenchResult result{"atbash", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
