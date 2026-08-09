#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string byte_reverse_encode(const std::string& input);
std::string byte_reverse_decode(const std::string& input);
bool byte_reverse_verify();
void byte_reverse_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
