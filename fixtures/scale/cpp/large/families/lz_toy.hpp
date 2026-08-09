#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string lz_toy_encode(const std::string& input);
std::string lz_toy_decode(const std::string& input);
bool lz_toy_verify();
void lz_toy_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
