#include "../families/rot13.hpp"
#include "../families/rot47.hpp"
#include "../families/rot5.hpp"
#include "../families/rot18.hpp"
#include "../families/caesar_shift.hpp"
#include "../families/atbash.hpp"
#include "../families/affine_cipher.hpp"
#include "../families/keyword_substitution.hpp"
#include "../families/vowel_cipher.hpp"
#include "../families/leetspeak_codec.hpp"

namespace registry_ns {

void registry_group_a_run(std::vector<core::BenchResult>& results) {
    codecs::rot13_bench_run(results);
    codecs::rot47_bench_run(results);
    codecs::rot5_bench_run(results);
    codecs::rot18_bench_run(results);
    codecs::caesar_shift_bench_run(results);
    codecs::atbash_bench_run(results);
    codecs::affine_cipher_bench_run(results);
    codecs::keyword_substitution_bench_run(results);
    codecs::vowel_cipher_bench_run(results);
    codecs::leetspeak_codec_bench_run(results);
}

} // namespace registry_ns
