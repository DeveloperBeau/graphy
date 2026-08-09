#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string checksum_adler_encode(const std::string& input);
std::string checksum_adler_decode(const std::string& input);
bool checksum_adler_verify();
void checksum_adler_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
