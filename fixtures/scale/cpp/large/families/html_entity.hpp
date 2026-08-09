#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string html_entity_encode(const std::string& input);
std::string html_entity_decode(const std::string& input);
bool html_entity_verify();
void html_entity_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
