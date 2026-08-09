#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string rot13_encode(const std::string& input);
std::string rot13_decode(const std::string& input);
bool rot13_verify();
void rot13_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
