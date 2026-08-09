#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string excess3_encoding_encode(const std::string& input);
std::string excess3_encoding_decode(const std::string& input);
bool excess3_encoding_verify();
void excess3_encoding_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
