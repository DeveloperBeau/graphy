#include "../families/line_ending_codec.hpp"
#include "../families/hex_encoding.hpp"
#include "../families/octal_encoding.hpp"
#include "../families/binary_string_encoding.hpp"
#include "../families/base36_encoding.hpp"
#include "../families/base62_encoding.hpp"
#include "../families/base58_encoding.hpp"
#include "../families/base45_encoding.hpp"
#include "../families/base85_encoding.hpp"
#include "../families/base64_custom.hpp"

namespace registry_ns {

void registry_group_e_run(std::vector<core::BenchResult>& results) {
    codecs::line_ending_codec_bench_run(results);
    codecs::hex_encoding_bench_run(results);
    codecs::octal_encoding_bench_run(results);
    codecs::binary_string_encoding_bench_run(results);
    codecs::base36_encoding_bench_run(results);
    codecs::base62_encoding_bench_run(results);
    codecs::base58_encoding_bench_run(results);
    codecs::base45_encoding_bench_run(results);
    codecs::base85_encoding_bench_run(results);
    codecs::base64_custom_bench_run(results);
}

} // namespace registry_ns
