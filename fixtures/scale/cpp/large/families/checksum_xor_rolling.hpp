#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string checksum_xor_rolling_encode(const std::string& input);
std::string checksum_xor_rolling_decode(const std::string& input);
bool checksum_xor_rolling_verify();
void checksum_xor_rolling_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
