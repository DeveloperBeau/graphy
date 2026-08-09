#include "excess3_encoding.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void excess3_encoding_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_digits(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::excess3_encoding_encode(sample);
    std::string decoded = codecs::excess3_encoding_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::excess3_encoding_verify() && decoded == sample;
    core::BenchResult result{"excess3_encoding", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
