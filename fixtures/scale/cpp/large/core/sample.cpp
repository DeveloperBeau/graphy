#include "sample.hpp"
#include <cstddef>

namespace core {

std::string sample_generate_text(int variant) {
    static const std::string options[] = {
        "The quick brown fox jumps over 42 lazy dogs, twice daily.",
        "Graph traversal visits every node exactly once before halting.",
        "Encoding schemes trade compactness for readability in practice."
    };
    return options[static_cast<std::size_t>(variant) % 3];
}

std::string sample_generate_digits(int variant) {
    static const std::string options[] = {"48512093785612", "90210581736402", "11224488001357"};
    return options[static_cast<std::size_t>(variant) % 3];
}

std::string sample_generate_letters(int variant) {
    static const std::string options[] = {"roseandstonepathway", "quietoceanvoyage", "amberlitforest"};
    return options[static_cast<std::size_t>(variant) % 3];
}

std::string sample_generate_bitstring(int variant) {
    static const std::string options[] = {
        "0011010111000101101001110000111",
        "1100001110101010000111100010101",
        "0101010101110000111100001111000"
    };
    return options[static_cast<std::size_t>(variant) % 3];
}

std::string sample_generate_uppercase(int variant) {
    static const std::string options[] = {"HELLO123WORLD456", "GRAPHY789BENCH001", "CODEC42SUITE99"};
    return options[static_cast<std::size_t>(variant) % 3];
}

std::string sample_generate_uppercase_letters(int variant) {
    static const std::string options[] = {"THEQUICKBROWNFOX", "PACKMYBOXWITHJUGS", "SPHINXOFBLACKQUARTZ"};
    return options[static_cast<std::size_t>(variant) % 3];
}

} // namespace core
