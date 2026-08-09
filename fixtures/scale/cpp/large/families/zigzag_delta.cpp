#include "zigzag_delta.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string zigzag_delta_encode(const std::string& input) {
    std::string out = input;
    unsigned char prev = 0;
    for (std::size_t i = 0; i < input.size(); ++i) {
        unsigned char cur = static_cast<unsigned char>(input[i]);
        signed char d = static_cast<signed char>(static_cast<unsigned char>(cur - prev));
        unsigned char zz = static_cast<unsigned char>((static_cast<int>(d) << 1) ^ (static_cast<int>(d) >> 7));
        out[i] = static_cast<char>(zz);
        prev = cur;
    }
    return out;
}

std::string zigzag_delta_decode(const std::string& input) {
    std::string out = input;
    unsigned char prev = 0;
    for (std::size_t i = 0; i < input.size(); ++i) {
        unsigned char zz = static_cast<unsigned char>(input[i]);
        int d = (static_cast<int>(zz) >> 1) ^ (-(static_cast<int>(zz) & 1));
        unsigned char cur = static_cast<unsigned char>(static_cast<int>(prev) + d);
        out[i] = static_cast<char>(cur);
        prev = cur;
    }
    return out;
}

bool zigzag_delta_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = zigzag_delta_encode(sample);
    std::string decoded = zigzag_delta_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
