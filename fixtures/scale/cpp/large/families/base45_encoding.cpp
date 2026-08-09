#include "base45_encoding.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string base45_encoding_encode(const std::string& input) {
    static const char* digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ $%*+-./:";
    std::string out;
    for (unsigned char c : input) {
        out += digits[c / 45];
        out += digits[c % 45];
    }
    return out;
}

std::string base45_encoding_decode(const std::string& input) {
    static const std::string digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ $%*+-./:";
    std::string out;
    for (std::size_t i = 0; i + 1 < input.size(); i += 2) {
        std::size_t hi = digits.find(input[i]);
        std::size_t lo = digits.find(input[i + 1]);
        out += static_cast<char>(hi * 45 + lo);
    }
    return out;
}

bool base45_encoding_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = base45_encoding_encode(sample);
    std::string decoded = base45_encoding_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
