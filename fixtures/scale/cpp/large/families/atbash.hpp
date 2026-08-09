#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string atbash_encode(const std::string& input);
std::string atbash_decode(const std::string& input);
bool atbash_verify();
void atbash_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
