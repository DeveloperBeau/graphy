#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string rot5_encode(const std::string& input);
std::string rot5_decode(const std::string& input);
bool rot5_verify();
void rot5_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
