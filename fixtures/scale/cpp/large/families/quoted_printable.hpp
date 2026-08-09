#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string quoted_printable_encode(const std::string& input);
std::string quoted_printable_decode(const std::string& input);
bool quoted_printable_verify();
void quoted_printable_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
