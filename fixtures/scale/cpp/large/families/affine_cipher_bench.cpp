#include "affine_cipher.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void affine_cipher_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::affine_cipher_encode(sample);
    std::string decoded = codecs::affine_cipher_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::affine_cipher_verify() && decoded == sample;
    core::BenchResult result{"affine_cipher", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
