#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string octal_encoding_encode(const std::string& input);
std::string octal_encoding_decode(const std::string& input);
bool octal_encoding_verify();
void octal_encoding_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
