#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string base62_encoding_encode(const std::string& input);
std::string base62_encoding_decode(const std::string& input);
bool base62_encoding_verify();
void base62_encoding_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
