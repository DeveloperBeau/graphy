#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string rot47_encode(const std::string& input);
std::string rot47_decode(const std::string& input);
bool rot47_verify();
void rot47_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
