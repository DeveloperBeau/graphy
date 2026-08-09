#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string whitespace_pack_encode(const std::string& input);
std::string whitespace_pack_decode(const std::string& input);
bool whitespace_pack_verify();
void whitespace_pack_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
