#include "stream_cipher_toy.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string stream_cipher_toy_encode(const std::string& input) {
    std::string out = input;
    unsigned long state = 12345UL;
    for (std::size_t i = 0; i < out.size(); ++i) {
        state = (1103515245UL * state + 12345UL) % 2147483648UL;
        unsigned char ks = static_cast<unsigned char>(state & 0xFFUL);
        out[i] = static_cast<char>(static_cast<unsigned char>(out[i]) ^ ks);
    }
    return out;
}

std::string stream_cipher_toy_decode(const std::string& input) {
    std::string out = input;
    unsigned long state = 12345UL;
    for (std::size_t i = 0; i < out.size(); ++i) {
        state = (1103515245UL * state + 12345UL) % 2147483648UL;
        unsigned char ks = static_cast<unsigned char>(state & 0xFFUL);
        out[i] = static_cast<char>(static_cast<unsigned char>(out[i]) ^ ks);
    }
    return out;
}

bool stream_cipher_toy_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = stream_cipher_toy_encode(sample);
    std::string decoded = stream_cipher_toy_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
