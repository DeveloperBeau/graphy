#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string ascii_shift_cipher_encode(const std::string& input);
std::string ascii_shift_cipher_decode(const std::string& input);
bool ascii_shift_cipher_verify();
void ascii_shift_cipher_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
