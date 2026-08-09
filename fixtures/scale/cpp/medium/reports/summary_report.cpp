#include "summary_report.hpp"
#include <sstream>

std::string summary_report_build(const CatalogStore& store, const MemberRegistry& registry) {
    std::ostringstream out;
    out << "books=" << store.catalog_store_size()
        << " active_members=" << registry.member_registry_active_count();
    return out.str();
}
