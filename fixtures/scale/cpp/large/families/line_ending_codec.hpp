#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string line_ending_codec_encode(const std::string& input);
std::string line_ending_codec_decode(const std::string& input);
bool line_ending_codec_verify();
void line_ending_codec_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
