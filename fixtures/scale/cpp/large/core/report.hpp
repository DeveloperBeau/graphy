#pragma once
#include <string>
#include <vector>
#include <cstddef>

namespace core {

// One codec family's benchmark outcome.
struct BenchResult {
    std::string family_name;
    double elapsed_ms;
    bool roundtrip_ok;
    std::size_t encoded_size;
};

void report_add(std::vector<BenchResult>& results, const BenchResult& item);
void report_print(const std::vector<BenchResult>& results);

} // namespace core
