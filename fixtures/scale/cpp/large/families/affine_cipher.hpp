#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string affine_cipher_encode(const std::string& input);
std::string affine_cipher_decode(const std::string& input);
bool affine_cipher_verify();
void affine_cipher_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
