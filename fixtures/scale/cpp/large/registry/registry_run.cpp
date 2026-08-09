#include "registry.hpp"
#include "../core/report.hpp"

namespace registry_ns {

void registry_run() {
    std::vector<core::BenchResult> results;
    registry_ns::registry_group_a_run(results);
    registry_ns::registry_group_b_run(results);
    registry_ns::registry_group_c_run(results);
    registry_ns::registry_group_d_run(results);
    registry_ns::registry_group_e_run(results);
    registry_ns::registry_group_f_run(results);
    core::report_print(results);
}

} // namespace registry_ns
