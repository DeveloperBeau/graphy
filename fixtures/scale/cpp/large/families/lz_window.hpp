#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string lz_window_encode(const std::string& input);
std::string lz_window_decode(const std::string& input);
bool lz_window_verify();
void lz_window_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
