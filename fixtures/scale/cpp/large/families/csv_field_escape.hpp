#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string csv_field_escape_encode(const std::string& input);
std::string csv_field_escape_decode(const std::string& input);
bool csv_field_escape_verify();
void csv_field_escape_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
