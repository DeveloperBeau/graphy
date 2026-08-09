#include "gray_code.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string gray_code_encode(const std::string& input) {
    std::string out = input;
    for (char& c : out) {
        unsigned char uc = static_cast<unsigned char>(c);
        unsigned char g = static_cast<unsigned char>(uc ^ (uc >> 1));
        c = static_cast<char>(g);
    }
    return out;
}

std::string gray_code_decode(const std::string& input) {
    std::string out = input;
    for (char& c : out) {
        unsigned char g = static_cast<unsigned char>(c);
        unsigned char b = g;
        for (unsigned char mask = static_cast<unsigned char>(b >> 1); mask != 0; mask = static_cast<unsigned char>(mask >> 1)) {
            b = static_cast<unsigned char>(b ^ mask);
        }
        c = static_cast<char>(b);
    }
    return out;
}

bool gray_code_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = gray_code_encode(sample);
    std::string decoded = gray_code_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
