#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string stream_cipher_toy_encode(const std::string& input);
std::string stream_cipher_toy_decode(const std::string& input);
bool stream_cipher_toy_verify();
void stream_cipher_toy_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
