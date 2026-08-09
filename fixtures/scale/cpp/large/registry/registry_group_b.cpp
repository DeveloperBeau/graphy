#include "../families/ascii_shift_cipher.hpp"
#include "../families/xor_diff.hpp"
#include "../families/delta_encoding.hpp"
#include "../families/nibble_swap.hpp"
#include "../families/byte_reverse.hpp"
#include "../families/offset_binary.hpp"
#include "../families/gray_code.hpp"
#include "../families/zigzag_delta.hpp"
#include "../families/interleave_codec.hpp"
#include "../families/columnar_transposition.hpp"

namespace registry_ns {

void registry_group_b_run(std::vector<core::BenchResult>& results) {
    codecs::ascii_shift_cipher_bench_run(results);
    codecs::xor_diff_bench_run(results);
    codecs::delta_encoding_bench_run(results);
    codecs::nibble_swap_bench_run(results);
    codecs::byte_reverse_bench_run(results);
    codecs::offset_binary_bench_run(results);
    codecs::gray_code_bench_run(results);
    codecs::zigzag_delta_bench_run(results);
    codecs::interleave_codec_bench_run(results);
    codecs::columnar_transposition_bench_run(results);
}

} // namespace registry_ns
