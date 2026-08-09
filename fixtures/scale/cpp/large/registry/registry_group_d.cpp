#include "../families/checksum_adler.hpp"
#include "../families/checksum_xor_rolling.hpp"
#include "../families/checksum_crc8.hpp"
#include "../families/quoted_printable.hpp"
#include "../families/url_encoding.hpp"
#include "../families/html_entity.hpp"
#include "../families/csv_field_escape.hpp"
#include "../families/json_string_escape.hpp"
#include "../families/whitespace_pack.hpp"
#include "../families/backslash_escape.hpp"

namespace registry_ns {

void registry_group_d_run(std::vector<core::BenchResult>& results) {
    codecs::checksum_adler_bench_run(results);
    codecs::checksum_xor_rolling_bench_run(results);
    codecs::checksum_crc8_bench_run(results);
    codecs::quoted_printable_bench_run(results);
    codecs::url_encoding_bench_run(results);
    codecs::html_entity_bench_run(results);
    codecs::csv_field_escape_bench_run(results);
    codecs::json_string_escape_bench_run(results);
    codecs::whitespace_pack_bench_run(results);
    codecs::backslash_escape_bench_run(results);
}

} // namespace registry_ns
