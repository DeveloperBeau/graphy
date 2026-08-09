#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string bit_pack_bools_encode(const std::string& input);
std::string bit_pack_bools_decode(const std::string& input);
bool bit_pack_bools_verify();
void bit_pack_bools_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
