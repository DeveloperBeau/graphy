#include "move_to_front.hpp"
#include "../core/sample.hpp"
#include <vector>

namespace codecs {

std::string move_to_front_encode(const std::string& input) {
    std::vector<unsigned char> table(256);
    for (int i = 0; i < 256; ++i) table[static_cast<std::size_t>(i)] = static_cast<unsigned char>(i);
    std::string out;
    for (unsigned char c : input) {
        std::size_t idx = 0;
        while (table[idx] != c) ++idx;
        out += static_cast<char>(idx);
        table.erase(table.begin() + static_cast<long>(idx));
        table.insert(table.begin(), c);
    }
    return out;
}

std::string move_to_front_decode(const std::string& input) {
    std::vector<unsigned char> table(256);
    for (int i = 0; i < 256; ++i) table[static_cast<std::size_t>(i)] = static_cast<unsigned char>(i);
    std::string out;
    for (unsigned char idx : input) {
        unsigned char c = table[idx];
        out += static_cast<char>(c);
        table.erase(table.begin() + idx);
        table.insert(table.begin(), c);
    }
    return out;
}

bool move_to_front_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = move_to_front_encode(sample);
    std::string decoded = move_to_front_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
