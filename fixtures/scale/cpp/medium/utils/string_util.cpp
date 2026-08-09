#include "string_util.hpp"
#include <algorithm>
#include <cctype>

namespace catalog_core {

std::string string_util_to_lower(const std::string& text) {
    std::string out = text;
    std::transform(out.begin(), out.end(), out.begin(),
                    [](unsigned char c) { return static_cast<char>(std::tolower(c)); });
    return out;
}

bool string_util_contains(const std::string& haystack, const std::string& needle) {
    std::string lower_haystack = string_util_to_lower(haystack);
    std::string lower_needle = string_util_to_lower(needle);
    return lower_haystack.find(lower_needle) != std::string::npos;
}

std::string string_util_trim(const std::string& text) {
    std::size_t start = text.find_first_not_of(" \t");
    std::size_t end = text.find_last_not_of(" \t");
    if (start == std::string::npos) return "";
    return text.substr(start, end - start + 1);
}

} // namespace catalog_core
