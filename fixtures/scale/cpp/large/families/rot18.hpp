#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string rot18_encode(const std::string& input);
std::string rot18_decode(const std::string& input);
bool rot18_verify();
void rot18_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
