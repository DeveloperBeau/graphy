#include "hex_encoding.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string hex_encoding_encode(const std::string& input) {
    static const char* hex_chars = "0123456789abcdef";
    std::string out;
    for (unsigned char c : input) {
        out += hex_chars[(c >> 4) & 0xF];
        out += hex_chars[c & 0xF];
    }
    return out;
}

std::string hex_encoding_decode(const std::string& input) {
    std::string out;
    for (std::size_t i = 0; i + 1 < input.size() + 1 && i + 2 <= input.size(); i += 2) {
        int value = std::stoi(input.substr(i, 2), nullptr, 16);
        out += static_cast<char>(value);
    }
    return out;
}

bool hex_encoding_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = hex_encoding_encode(sample);
    std::string decoded = hex_encoding_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
