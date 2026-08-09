#include "rot13.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void rot13_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::rot13_encode(sample);
    std::string decoded = codecs::rot13_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::rot13_verify() && decoded == sample;
    core::BenchResult result{"rot13", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
