#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string backslash_escape_encode(const std::string& input);
std::string backslash_escape_decode(const std::string& input);
bool backslash_escape_verify();
void backslash_escape_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
