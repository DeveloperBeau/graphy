#include "nibble_swap.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string nibble_swap_encode(const std::string& input) {
    std::string out = input;
    for (char& c : out) {
        unsigned char uc = static_cast<unsigned char>(c);
        uc = static_cast<unsigned char>(((uc & 0x0F) << 4) | ((uc & 0xF0) >> 4));
        c = static_cast<char>(uc);
    }
    return out;
}

std::string nibble_swap_decode(const std::string& input) {
    std::string out = input;
    for (char& c : out) {
        unsigned char uc = static_cast<unsigned char>(c);
        uc = static_cast<unsigned char>(((uc & 0x0F) << 4) | ((uc & 0xF0) >> 4));
        c = static_cast<char>(uc);
    }
    return out;
}

bool nibble_swap_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = nibble_swap_encode(sample);
    std::string decoded = nibble_swap_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
