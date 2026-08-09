#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string hex_encoding_encode(const std::string& input);
std::string hex_encoding_decode(const std::string& input);
bool hex_encoding_verify();
void hex_encoding_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
