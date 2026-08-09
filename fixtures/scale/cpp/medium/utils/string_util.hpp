#pragma once
#include <string>

namespace catalog_core {

// Small string helpers used by search and reporting code.
std::string string_util_to_lower(const std::string& text);
bool string_util_contains(const std::string& haystack, const std::string& needle);
std::string string_util_trim(const std::string& text);

} // namespace catalog_core
