#include "dictionary_words.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void dictionary_words_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::dictionary_words_encode(sample);
    std::string decoded = codecs::dictionary_words_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::dictionary_words_verify() && decoded == sample;
    core::BenchResult result{"dictionary_words", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
