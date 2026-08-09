#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string url_encoding_encode(const std::string& input);
std::string url_encoding_decode(const std::string& input);
bool url_encoding_verify();
void url_encoding_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
