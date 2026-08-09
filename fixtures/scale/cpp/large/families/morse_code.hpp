#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string morse_code_encode(const std::string& input);
std::string morse_code_decode(const std::string& input);
bool morse_code_verify();
void morse_code_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
