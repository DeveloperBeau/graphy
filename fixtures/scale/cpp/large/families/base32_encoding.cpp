#include "base32_encoding.hpp"
#include "../core/sample.hpp"
#include <cctype>

namespace codecs {

std::string base32_encoding_encode(const std::string& input) {
    static const char* alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567";
    std::string out;
    unsigned int buffer = 0;
    int bits = 0;
    for (unsigned char c : input) {
        buffer = (buffer << 8) | c;
        bits += 8;
        while (bits >= 5) {
            out += alpha[(buffer >> (bits - 5)) & 0x1F];
            bits -= 5;
        }
        buffer &= (bits == 0) ? 0u : ((1u << bits) - 1);
    }
    if (bits > 0) {
        out += alpha[(buffer << (5 - bits)) & 0x1F];
    }
    while (out.size() % 8 != 0) out += '=';
    return out;
}

std::string base32_encoding_decode(const std::string& input) {
    static const std::string alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567";
    std::string out;
    unsigned int buffer = 0;
    int bits = 0;
    for (char raw : input) {
        if (raw == '=') break;
        std::size_t idx = alpha.find(static_cast<char>(std::toupper(static_cast<unsigned char>(raw))));
        if (idx == std::string::npos) continue;
        buffer = (buffer << 5) | static_cast<unsigned int>(idx);
        bits += 5;
        if (bits >= 8) {
            out += static_cast<char>((buffer >> (bits - 8)) & 0xFF);
            bits -= 8;
        }
        buffer &= (bits == 0) ? 0u : ((1u << bits) - 1);
    }
    return out;
}

bool base32_encoding_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = base32_encoding_encode(sample);
    std::string decoded = base32_encoding_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
