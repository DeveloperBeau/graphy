#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string dictionary_words_encode(const std::string& input);
std::string dictionary_words_decode(const std::string& input);
bool dictionary_words_verify();
void dictionary_words_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
