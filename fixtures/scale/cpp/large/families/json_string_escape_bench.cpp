#include "json_string_escape.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void json_string_escape_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::json_string_escape_encode(sample);
    std::string decoded = codecs::json_string_escape_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::json_string_escape_verify() && decoded == sample;
    core::BenchResult result{"json_string_escape", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
