#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string xor_diff_encode(const std::string& input);
std::string xor_diff_decode(const std::string& input);
bool xor_diff_verify();
void xor_diff_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
