#include "base62_encoding.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string base62_encoding_encode(const std::string& input) {
    static const char* digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    std::string out;
    for (unsigned char c : input) {
        out += digits[c / 62];
        out += digits[c % 62];
    }
    return out;
}

std::string base62_encoding_decode(const std::string& input) {
    auto value_of = [](char c) -> int {
        if (c >= '0' && c <= '9') return c - '0';
        if (c >= 'A' && c <= 'Z') return 10 + (c - 'A');
        return 36 + (c - 'a');
    };
    std::string out;
    for (std::size_t i = 0; i + 1 < input.size(); i += 2) {
        int hi = value_of(input[i]);
        int lo = value_of(input[i + 1]);
        out += static_cast<char>(hi * 62 + lo);
    }
    return out;
}

bool base62_encoding_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = base62_encoding_encode(sample);
    std::string decoded = base62_encoding_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
