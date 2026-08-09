#pragma once
#include <string>

// A parsed search request: a keyword plus an optional author filter.
struct SearchQuery {
    std::string keyword;
    std::string author_filter;
};

namespace catalog_core {

SearchQuery search_query_parse(const std::string& raw_text);

} // namespace catalog_core
