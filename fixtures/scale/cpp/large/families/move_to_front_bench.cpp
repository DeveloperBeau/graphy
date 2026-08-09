#include "move_to_front.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void move_to_front_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::move_to_front_encode(sample);
    std::string decoded = codecs::move_to_front_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::move_to_front_verify() && decoded == sample;
    core::BenchResult result{"move_to_front", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
