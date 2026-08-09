#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string gray_code_encode(const std::string& input);
std::string gray_code_decode(const std::string& input);
bool gray_code_verify();
void gray_code_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
