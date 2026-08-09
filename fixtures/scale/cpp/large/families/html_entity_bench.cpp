#include "html_entity.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void html_entity_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::html_entity_encode(sample);
    std::string decoded = codecs::html_entity_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::html_entity_verify() && decoded == sample;
    core::BenchResult result{"html_entity", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
