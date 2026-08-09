#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string nibble_swap_encode(const std::string& input);
std::string nibble_swap_decode(const std::string& input);
bool nibble_swap_verify();
void nibble_swap_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
