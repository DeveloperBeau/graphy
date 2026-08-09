#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string xor_key_rotate_encode(const std::string& input);
std::string xor_key_rotate_decode(const std::string& input);
bool xor_key_rotate_verify();
void xor_key_rotate_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
