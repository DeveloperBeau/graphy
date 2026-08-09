#pragma once
#include <string>
#include "../catalog/catalog_store.hpp"
#include "../members/member_registry.hpp"

// A one-line snapshot of catalog and membership size.
std::string summary_report_build(const CatalogStore& store, const MemberRegistry& registry);
