#include "search_query.hpp"
#include "../utils/string_util.hpp"

namespace catalog_core {

SearchQuery search_query_parse(const std::string& raw_text) {
    std::string trimmed = catalog_core::string_util_trim(raw_text);
    SearchQuery query;
    std::size_t separator = trimmed.find('@');
    if (separator == std::string::npos) {
        query.keyword = trimmed;
    } else {
        query.keyword = trimmed.substr(0, separator);
        query.author_filter = trimmed.substr(separator + 1);
    }
    return query;
}

} // namespace catalog_core
