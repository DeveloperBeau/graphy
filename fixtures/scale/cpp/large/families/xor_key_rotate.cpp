#include "xor_key_rotate.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string xor_key_rotate_encode(const std::string& input) {
    static const std::string key = "KEYX";
    std::string out = input;
    for (std::size_t i = 0; i < out.size(); ++i) {
        out[i] = static_cast<char>(static_cast<unsigned char>(out[i]) ^ static_cast<unsigned char>(key[i % key.size()]));
    }
    return out;
}

std::string xor_key_rotate_decode(const std::string& input) {
    static const std::string key = "KEYX";
    std::string out = input;
    for (std::size_t i = 0; i < out.size(); ++i) {
        out[i] = static_cast<char>(static_cast<unsigned char>(out[i]) ^ static_cast<unsigned char>(key[i % key.size()]));
    }
    return out;
}

bool xor_key_rotate_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = xor_key_rotate_encode(sample);
    std::string decoded = xor_key_rotate_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
