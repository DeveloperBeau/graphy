#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string keyword_substitution_encode(const std::string& input);
std::string keyword_substitution_decode(const std::string& input);
bool keyword_substitution_verify();
void keyword_substitution_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
