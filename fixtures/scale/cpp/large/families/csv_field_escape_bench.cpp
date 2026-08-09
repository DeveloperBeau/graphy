#include "csv_field_escape.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void csv_field_escape_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::csv_field_escape_encode(sample);
    std::string decoded = codecs::csv_field_escape_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::csv_field_escape_verify() && decoded == sample;
    core::BenchResult result{"csv_field_escape", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
