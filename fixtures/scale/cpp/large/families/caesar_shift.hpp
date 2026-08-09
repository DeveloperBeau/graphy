#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string caesar_shift_encode(const std::string& input);
std::string caesar_shift_decode(const std::string& input);
bool caesar_shift_verify();
void caesar_shift_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
