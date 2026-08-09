#include "ascii_shift_cipher.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string ascii_shift_cipher_encode(const std::string& input) {
    std::string out = input;
    for (char& c : out) {
        unsigned char uc = static_cast<unsigned char>(c);
        uc = static_cast<unsigned char>((uc + 17) % 256);
        c = static_cast<char>(uc);
    }
    return out;
}

std::string ascii_shift_cipher_decode(const std::string& input) {
    std::string out = input;
    for (char& c : out) {
        unsigned char uc = static_cast<unsigned char>(c);
        uc = static_cast<unsigned char>((uc + 256 - 17) % 256);
        c = static_cast<char>(uc);
    }
    return out;
}

bool ascii_shift_cipher_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = ascii_shift_cipher_encode(sample);
    std::string decoded = ascii_shift_cipher_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
