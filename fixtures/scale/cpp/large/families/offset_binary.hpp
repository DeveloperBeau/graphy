#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string offset_binary_encode(const std::string& input);
std::string offset_binary_decode(const std::string& input);
bool offset_binary_verify();
void offset_binary_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
