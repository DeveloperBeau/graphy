#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string checksum_luhn_encode(const std::string& input);
std::string checksum_luhn_decode(const std::string& input);
bool checksum_luhn_verify();
void checksum_luhn_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
