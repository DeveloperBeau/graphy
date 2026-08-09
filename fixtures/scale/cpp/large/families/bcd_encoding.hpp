#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string bcd_encoding_encode(const std::string& input);
std::string bcd_encoding_decode(const std::string& input);
bool bcd_encoding_verify();
void bcd_encoding_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
