#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string interleave_codec_encode(const std::string& input);
std::string interleave_codec_decode(const std::string& input);
bool interleave_codec_verify();
void interleave_codec_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
