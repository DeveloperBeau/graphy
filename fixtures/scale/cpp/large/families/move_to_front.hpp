#pragma once
#include <string>
#include <vector>
#include "../core/report.hpp"

namespace codecs {

std::string move_to_front_encode(const std::string& input);
std::string move_to_front_decode(const std::string& input);
bool move_to_front_verify();
void move_to_front_bench_run(std::vector<core::BenchResult>& results);

} // namespace codecs
