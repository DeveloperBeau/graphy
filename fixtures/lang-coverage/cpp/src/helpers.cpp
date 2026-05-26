// feature: function, namespace, #include local
#include "types.hpp"
#include <string>

namespace graphy {

std::string format_name(const std::string& name) {
    return "hi, " + name;
}

int unrelated_helper() {
    return 7;
}

} // namespace graphy
