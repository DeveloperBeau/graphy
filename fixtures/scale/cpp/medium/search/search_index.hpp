#pragma once
#include <vector>
#include "../catalog/catalog_store.hpp"
#include "search_query.hpp"

// Runs simple keyword queries against a catalog store.
std::vector<Book> search_index_run(const CatalogStore& store, const SearchQuery& query);
