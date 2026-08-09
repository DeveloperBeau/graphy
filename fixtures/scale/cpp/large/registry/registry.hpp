#pragma once
#include <vector>
#include "../core/report.hpp"

namespace registry_ns {

void registry_group_a_run(std::vector<core::BenchResult>& results);
void registry_group_b_run(std::vector<core::BenchResult>& results);
void registry_group_c_run(std::vector<core::BenchResult>& results);
void registry_group_d_run(std::vector<core::BenchResult>& results);
void registry_group_e_run(std::vector<core::BenchResult>& results);
void registry_group_f_run(std::vector<core::BenchResult>& results);
void registry_run();

} // namespace registry_ns
