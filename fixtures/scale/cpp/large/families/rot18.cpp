#include "rot18.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string rot18_encode(const std::string& input) {
    std::string out = input;
    for (char& c : out) {
        if (c >= 'a' && c <= 'z') c = static_cast<char>('a' + (c - 'a' + 13) % 26);
        else if (c >= 'A' && c <= 'Z') c = static_cast<char>('A' + (c - 'A' + 13) % 26);
        else if (c >= '0' && c <= '9') c = static_cast<char>('0' + (c - '0' + 5) % 10);
    }
    return out;
}

std::string rot18_decode(const std::string& input) {
    std::string out = input;
    for (char& c : out) {
        if (c >= 'a' && c <= 'z') c = static_cast<char>('a' + (c - 'a' + 13) % 26);
        else if (c >= 'A' && c <= 'Z') c = static_cast<char>('A' + (c - 'A' + 13) % 26);
        else if (c >= '0' && c <= '9') c = static_cast<char>('0' + (c - '0' + 5) % 10);
    }
    return out;
}

bool rot18_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = rot18_encode(sample);
    std::string decoded = rot18_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
