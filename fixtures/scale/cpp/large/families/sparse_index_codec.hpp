#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string sparse_index_codec_encode(const std::string& input);
std::string sparse_index_codec_decode(const std::string& input);
bool sparse_index_codec_verify();
void sparse_index_codec_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
