#include "base64_custom.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string base64_custom_encode(const std::string& input) {
    static const char* alpha =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    std::string out;
    std::size_t i = 0;
    while (i + 3 <= input.size()) {
        unsigned int n = (static_cast<unsigned char>(input[i]) << 16)
                        | (static_cast<unsigned char>(input[i + 1]) << 8)
                        | static_cast<unsigned char>(input[i + 2]);
        out += alpha[(n >> 18) & 0x3F];
        out += alpha[(n >> 12) & 0x3F];
        out += alpha[(n >> 6) & 0x3F];
        out += alpha[n & 0x3F];
        i += 3;
    }
    std::size_t remain = input.size() - i;
    if (remain == 1) {
        unsigned int n = static_cast<unsigned int>(static_cast<unsigned char>(input[i])) << 16;
        out += alpha[(n >> 18) & 0x3F];
        out += alpha[(n >> 12) & 0x3F];
        out += "==";
    } else if (remain == 2) {
        unsigned int n = (static_cast<unsigned int>(static_cast<unsigned char>(input[i])) << 16)
                        | (static_cast<unsigned int>(static_cast<unsigned char>(input[i + 1])) << 8);
        out += alpha[(n >> 18) & 0x3F];
        out += alpha[(n >> 12) & 0x3F];
        out += alpha[(n >> 6) & 0x3F];
        out += "=";
    }
    return out;
}

std::string base64_custom_decode(const std::string& input) {
    static const std::string alpha =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    std::string out;
    std::size_t i = 0;
    while (i + 4 <= input.size()) {
        int c0 = static_cast<int>(alpha.find(input[i]));
        int c1 = static_cast<int>(alpha.find(input[i + 1]));
        int c2 = (input[i + 2] == '=') ? -1 : static_cast<int>(alpha.find(input[i + 2]));
        int c3 = (input[i + 3] == '=') ? -1 : static_cast<int>(alpha.find(input[i + 3]));
        unsigned int n = (static_cast<unsigned int>(c0) << 18) | (static_cast<unsigned int>(c1) << 12);
        out += static_cast<char>((n >> 16) & 0xFF);
        if (c2 >= 0) {
            n |= static_cast<unsigned int>(c2) << 6;
            out += static_cast<char>((n >> 8) & 0xFF);
        }
        if (c3 >= 0) {
            n |= static_cast<unsigned int>(c3);
            out += static_cast<char>(n & 0xFF);
        }
        i += 4;
    }
    return out;
}

bool base64_custom_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = base64_custom_encode(sample);
    std::string decoded = base64_custom_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
