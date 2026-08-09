#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string leetspeak_codec_encode(const std::string& input);
std::string leetspeak_codec_decode(const std::string& input);
bool leetspeak_codec_verify();
void leetspeak_codec_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
