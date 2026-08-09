#include "columnar_transposition.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void columnar_transposition_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::columnar_transposition_encode(sample);
    std::string decoded = codecs::columnar_transposition_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::columnar_transposition_verify() && decoded == sample;
    core::BenchResult result{"columnar_transposition", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
