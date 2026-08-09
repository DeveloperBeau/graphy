#include "checksum_xor_rolling.hpp"
#include "../core/sample.hpp"
#include <stdexcept>

namespace codecs {

std::string checksum_xor_rolling_encode(const std::string& input) {
    unsigned char acc = 0;
    for (std::size_t i = 0; i < input.size(); ++i) {
        unsigned char c = static_cast<unsigned char>(input[i]);
        unsigned int shift = static_cast<unsigned int>(i % 8);
        unsigned char rotated = (shift == 0) ? c : static_cast<unsigned char>((c << shift) | (c >> (8 - shift)));
        acc ^= rotated;
    }
    return input + static_cast<char>(acc);
}

std::string checksum_xor_rolling_decode(const std::string& input) {
    if (input.empty()) throw std::runtime_error("checksum_xor_rolling_decode: empty input");
    std::string data = input.substr(0, input.size() - 1);
    unsigned char acc = 0;
    for (std::size_t i = 0; i < data.size(); ++i) {
        unsigned char c = static_cast<unsigned char>(data[i]);
        unsigned int shift = static_cast<unsigned int>(i % 8);
        unsigned char rotated = (shift == 0) ? c : static_cast<unsigned char>((c << shift) | (c >> (8 - shift)));
        acc ^= rotated;
    }
    unsigned char stored = static_cast<unsigned char>(input.back());
    if (acc != stored) throw std::runtime_error("checksum_xor_rolling_decode: mismatch");
    return data;
}

bool checksum_xor_rolling_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = checksum_xor_rolling_encode(sample);
    std::string decoded = checksum_xor_rolling_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
