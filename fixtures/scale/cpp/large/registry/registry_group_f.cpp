#include "../families/base32_encoding.hpp"
#include "../families/lz_toy.hpp"
#include "../families/lz_window.hpp"
#include "../families/dictionary_words.hpp"
#include "../families/move_to_front.hpp"
#include "../families/morse_code.hpp"
#include "../families/baudot_code.hpp"
#include "../families/bcd_encoding.hpp"
#include "../families/excess3_encoding.hpp"
#include "../families/checksum_luhn.hpp"

namespace registry_ns {

void registry_group_f_run(std::vector<core::BenchResult>& results) {
    codecs::base32_encoding_bench_run(results);
    codecs::lz_toy_bench_run(results);
    codecs::lz_window_bench_run(results);
    codecs::dictionary_words_bench_run(results);
    codecs::move_to_front_bench_run(results);
    codecs::morse_code_bench_run(results);
    codecs::baudot_code_bench_run(results);
    codecs::bcd_encoding_bench_run(results);
    codecs::excess3_encoding_bench_run(results);
    codecs::checksum_luhn_bench_run(results);
}

} // namespace registry_ns
