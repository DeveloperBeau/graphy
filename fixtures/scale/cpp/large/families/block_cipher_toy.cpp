#include "block_cipher_toy.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string block_cipher_toy_encode(const std::string& input) {
    std::string out = input;
    const std::size_t block_size = 4;
    for (std::size_t i = 0; i < out.size(); ++i) {
        std::size_t block_index = i / block_size;
        unsigned char key = static_cast<unsigned char>((block_index * 37 + 11) % 256);
        out[i] = static_cast<char>(static_cast<unsigned char>(out[i]) ^ key);
    }
    return out;
}

std::string block_cipher_toy_decode(const std::string& input) {
    std::string out = input;
    const std::size_t block_size = 4;
    for (std::size_t i = 0; i < out.size(); ++i) {
        std::size_t block_index = i / block_size;
        unsigned char key = static_cast<unsigned char>((block_index * 37 + 11) % 256);
        out[i] = static_cast<char>(static_cast<unsigned char>(out[i]) ^ key);
    }
    return out;
}

bool block_cipher_toy_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = block_cipher_toy_encode(sample);
    std::string decoded = block_cipher_toy_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
