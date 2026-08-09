#include "report.hpp"
#include <iostream>

namespace core {

void report_add(std::vector<BenchResult>& results, const BenchResult& item) {
    results.push_back(item);
}

void report_print(const std::vector<BenchResult>& results) {
    std::size_t failures = 0;
    for (const BenchResult& item : results) {
        std::cout << item.family_name << " ok=" << item.roundtrip_ok
                   << " size=" << item.encoded_size
                   << " ms=" << item.elapsed_ms << std::endl;
        if (!item.roundtrip_ok) ++failures;
    }
    std::cout << "families=" << results.size() << " failures=" << failures << std::endl;
}

} // namespace core
