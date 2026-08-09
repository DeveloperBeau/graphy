#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string json_string_escape_encode(const std::string& input);
std::string json_string_escape_decode(const std::string& input);
bool json_string_escape_verify();
void json_string_escape_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
