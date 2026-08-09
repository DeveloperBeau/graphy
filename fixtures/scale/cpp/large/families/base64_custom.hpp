#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string base64_custom_encode(const std::string& input);
std::string base64_custom_decode(const std::string& input);
bool base64_custom_verify();
void base64_custom_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
