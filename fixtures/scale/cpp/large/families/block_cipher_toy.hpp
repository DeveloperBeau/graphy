#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string block_cipher_toy_encode(const std::string& input);
std::string block_cipher_toy_decode(const std::string& input);
bool block_cipher_toy_verify();
void block_cipher_toy_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
