#include "vowel_cipher.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void vowel_cipher_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_letters(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::vowel_cipher_encode(sample);
    std::string decoded = codecs::vowel_cipher_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::vowel_cipher_verify() && decoded == sample;
    core::BenchResult result{"vowel_cipher", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
