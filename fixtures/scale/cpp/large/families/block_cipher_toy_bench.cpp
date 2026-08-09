#include "block_cipher_toy.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void block_cipher_toy_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_text(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::block_cipher_toy_encode(sample);
    std::string decoded = codecs::block_cipher_toy_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::block_cipher_toy_verify() && decoded == sample;
    core::BenchResult result{"block_cipher_toy", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
