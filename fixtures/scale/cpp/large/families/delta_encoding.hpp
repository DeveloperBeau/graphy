#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string delta_encoding_encode(const std::string& input);
std::string delta_encoding_decode(const std::string& input);
bool delta_encoding_verify();
void delta_encoding_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
