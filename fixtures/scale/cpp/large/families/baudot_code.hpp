#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string baudot_code_encode(const std::string& input);
std::string baudot_code_decode(const std::string& input);
bool baudot_code_verify();
void baudot_code_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
