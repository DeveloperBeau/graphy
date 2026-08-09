#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string zigzag_delta_encode(const std::string& input);
std::string zigzag_delta_decode(const std::string& input);
bool zigzag_delta_verify();
void zigzag_delta_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
