#include "affine_cipher.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string affine_cipher_encode(const std::string& input) {
    std::string out = input;
    for (char& c : out) {
        if (c >= 'a' && c <= 'z') c = static_cast<char>('a' + (5 * (c - 'a') + 8) % 26);
        else if (c >= 'A' && c <= 'Z') c = static_cast<char>('A' + (5 * (c - 'A') + 8) % 26);
    }
    return out;
}

std::string affine_cipher_decode(const std::string& input) {
    std::string out = input;
    for (char& c : out) {
        if (c >= 'a' && c <= 'z') {
            int y = c - 'a';
            int x = (21 * (y - 8 + 260)) % 26;
            c = static_cast<char>('a' + x);
        } else if (c >= 'A' && c <= 'Z') {
            int y = c - 'A';
            int x = (21 * (y - 8 + 260)) % 26;
            c = static_cast<char>('A' + x);
        }
    }
    return out;
}

bool affine_cipher_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = affine_cipher_encode(sample);
    std::string decoded = affine_cipher_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
