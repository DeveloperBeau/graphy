#include "rot18.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void rot18_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::rot18_encode(sample);
    std::string decoded = codecs::rot18_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::rot18_verify() && decoded == sample;
    core::BenchResult result{"rot18", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
