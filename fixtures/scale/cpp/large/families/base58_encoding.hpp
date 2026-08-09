#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string base58_encoding_encode(const std::string& input);
std::string base58_encoding_decode(const std::string& input);
bool base58_encoding_verify();
void base58_encoding_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
