#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string bitmap_rle_encode(const std::string& input);
std::string bitmap_rle_decode(const std::string& input);
bool bitmap_rle_verify();
void bitmap_rle_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
