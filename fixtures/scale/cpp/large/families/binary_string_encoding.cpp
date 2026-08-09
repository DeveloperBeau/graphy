#include "binary_string_encoding.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string binary_string_encoding_encode(const std::string& input) {
    std::string out;
    for (unsigned char c : input) {
        for (int bit = 7; bit >= 0; --bit) {
            out += ((c >> bit) & 1) ? '1' : '0';
        }
    }
    return out;
}

std::string binary_string_encoding_decode(const std::string& input) {
    std::string out;
    for (std::size_t i = 0; i + 8 <= input.size(); i += 8) {
        unsigned char value = 0;
        for (int bit = 0; bit < 8; ++bit) {
            value = static_cast<unsigned char>((value << 1) | (input[i + static_cast<std::size_t>(bit)] == '1' ? 1 : 0));
        }
        out += static_cast<char>(value);
    }
    return out;
}

bool binary_string_encoding_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = binary_string_encoding_encode(sample);
    std::string decoded = binary_string_encoding_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
