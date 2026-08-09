#include "xor_diff.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string xor_diff_encode(const std::string& input) {
    std::string out = input;
    unsigned char prev = 0;
    for (std::size_t i = 0; i < input.size(); ++i) {
        unsigned char cur = static_cast<unsigned char>(input[i]);
        out[i] = static_cast<char>(cur ^ prev);
        prev = cur;
    }
    return out;
}

std::string xor_diff_decode(const std::string& input) {
    std::string out = input;
    unsigned char prev = 0;
    for (std::size_t i = 0; i < input.size(); ++i) {
        unsigned char cur = static_cast<unsigned char>(static_cast<unsigned char>(input[i]) ^ prev);
        out[i] = static_cast<char>(cur);
        prev = cur;
    }
    return out;
}

bool xor_diff_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = xor_diff_encode(sample);
    std::string decoded = xor_diff_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
