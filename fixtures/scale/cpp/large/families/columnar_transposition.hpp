#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string columnar_transposition_encode(const std::string& input);
std::string columnar_transposition_decode(const std::string& input);
bool columnar_transposition_verify();
void columnar_transposition_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
