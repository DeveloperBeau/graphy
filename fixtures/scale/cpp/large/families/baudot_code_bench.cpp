#include "baudot_code.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void baudot_code_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_uppercase_letters(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::baudot_code_encode(sample);
    std::string decoded = codecs::baudot_code_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::baudot_code_verify() && decoded == sample;
    core::BenchResult result{"baudot_code", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
