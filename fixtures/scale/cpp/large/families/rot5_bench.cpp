#include "rot5.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void rot5_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::rot5_encode(sample);
    std::string decoded = codecs::rot5_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::rot5_verify() && decoded == sample;
    core::BenchResult result{"rot5", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
