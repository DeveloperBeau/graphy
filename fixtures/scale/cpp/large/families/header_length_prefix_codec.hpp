#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string header_length_prefix_codec_encode(const std::string& input);
std::string header_length_prefix_codec_decode(const std::string& input);
bool header_length_prefix_codec_verify();
void header_length_prefix_codec_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
