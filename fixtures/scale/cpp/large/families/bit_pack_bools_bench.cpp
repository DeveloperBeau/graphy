#include "bit_pack_bools.hpp"
#include "../core/timer.hpp"
#include "../core/sample.hpp"

namespace codecs {

void bit_pack_bools_bench_run(std::vector<core::BenchResult>& results) {
    std::string sample = core::sample_generate_bitstring(1);
    core::Timer timer;
    timer.timer_start();
    std::string encoded = codecs::bit_pack_bools_encode(sample);
    std::string decoded = codecs::bit_pack_bools_decode(encoded);
    double elapsed = timer.timer_elapsed_ms();
    bool ok = codecs::bit_pack_bools_verify() && decoded == sample;
    core::BenchResult result{"bit_pack_bools", elapsed, ok, encoded.size()};
    core::report_add(results, result);
}

} // namespace codecs
