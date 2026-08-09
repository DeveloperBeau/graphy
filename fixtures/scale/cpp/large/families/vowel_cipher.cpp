#include "vowel_cipher.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string vowel_cipher_encode(const std::string& input) {
    std::string out = input;
    for (char& c : out) {
        switch (c) {
            case 'a': c = 'e'; break;
            case 'e': c = 'a'; break;
            case 'i': c = 'o'; break;
            case 'o': c = 'i'; break;
            case 'A': c = 'E'; break;
            case 'E': c = 'A'; break;
            case 'I': c = 'O'; break;
            case 'O': c = 'I'; break;
            default: break;
        }
    }
    return out;
}

std::string vowel_cipher_decode(const std::string& input) {
    std::string out = input;
    for (char& c : out) {
        switch (c) {
            case 'a': c = 'e'; break;
            case 'e': c = 'a'; break;
            case 'i': c = 'o'; break;
            case 'o': c = 'i'; break;
            case 'A': c = 'E'; break;
            case 'E': c = 'A'; break;
            case 'I': c = 'O'; break;
            case 'O': c = 'I'; break;
            default: break;
        }
    }
    return out;
}

bool vowel_cipher_verify() {
    std::string sample = core::sample_generate_letters(1);
    std::string encoded = vowel_cipher_encode(sample);
    std::string decoded = vowel_cipher_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
