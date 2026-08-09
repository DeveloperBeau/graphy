#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string vowel_cipher_encode(const std::string& input);
std::string vowel_cipher_decode(const std::string& input);
bool vowel_cipher_verify();
void vowel_cipher_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
