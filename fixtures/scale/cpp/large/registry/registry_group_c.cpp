#include "../families/spacing_codec.hpp"
#include "../families/header_length_prefix_codec.hpp"
#include "../families/bit_pack_bools.hpp"
#include "../families/bitmap_rle.hpp"
#include "../families/sparse_index_codec.hpp"
#include "../families/xor_key_rotate.hpp"
#include "../families/stream_cipher_toy.hpp"
#include "../families/block_cipher_toy.hpp"
#include "../families/checksum_parity.hpp"
#include "../families/checksum_fletcher.hpp"

namespace registry_ns {

void registry_group_c_run(std::vector<core::BenchResult>& results) {
    codecs::spacing_codec_bench_run(results);
    codecs::header_length_prefix_codec_bench_run(results);
    codecs::bit_pack_bools_bench_run(results);
    codecs::bitmap_rle_bench_run(results);
    codecs::sparse_index_codec_bench_run(results);
    codecs::xor_key_rotate_bench_run(results);
    codecs::stream_cipher_toy_bench_run(results);
    codecs::block_cipher_toy_bench_run(results);
    codecs::checksum_parity_bench_run(results);
    codecs::checksum_fletcher_bench_run(results);
}

} // namespace registry_ns
