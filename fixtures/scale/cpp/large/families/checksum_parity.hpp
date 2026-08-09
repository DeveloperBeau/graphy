#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string checksum_parity_encode(const std::string& input);
std::string checksum_parity_decode(const std::string& input);
bool checksum_parity_verify();
void checksum_parity_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
