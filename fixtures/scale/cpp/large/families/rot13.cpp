#include "rot13.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string rot13_encode(const std::string& input) {
    std::string out = input;
    for (char& c : out) {
        if (c >= 'a' && c <= 'z') c = static_cast<char>('a' + (c - 'a' + 13) % 26);
        else if (c >= 'A' && c <= 'Z') c = static_cast<char>('A' + (c - 'A' + 13) % 26);
    }
    return out;
}

std::string rot13_decode(const std::string& input) {
    std::string out = input;
    for (char& c : out) {
        if (c >= 'a' && c <= 'z') c = static_cast<char>('a' + (c - 'a' + 13) % 26);
        else if (c >= 'A' && c <= 'Z') c = static_cast<char>('A' + (c - 'A' + 13) % 26);
    }
    return out;
}

bool rot13_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = rot13_encode(sample);
    std::string decoded = rot13_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
