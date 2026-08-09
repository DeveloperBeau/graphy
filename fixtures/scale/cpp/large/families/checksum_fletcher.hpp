#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string checksum_fletcher_encode(const std::string& input);
std::string checksum_fletcher_decode(const std::string& input);
bool checksum_fletcher_verify();
void checksum_fletcher_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
