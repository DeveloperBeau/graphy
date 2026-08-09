#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string binary_string_encoding_encode(const std::string& input);
std::string binary_string_encoding_decode(const std::string& input);
bool binary_string_encoding_verify();
void binary_string_encoding_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
