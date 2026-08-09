#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string base36_encoding_encode(const std::string& input);
std::string base36_encoding_decode(const std::string& input);
bool base36_encoding_verify();
void base36_encoding_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
