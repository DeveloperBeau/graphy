#include "rot47.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string rot47_encode(const std::string& input) {
    std::string out = input;
    for (char& c : out) {
        unsigned char uc = static_cast<unsigned char>(c);
        if (uc >= 33 && uc <= 126) {
            uc = static_cast<unsigned char>(33 + (uc - 33 + 47) % 94);
            c = static_cast<char>(uc);
        }
    }
    return out;
}

std::string rot47_decode(const std::string& input) {
    std::string out = input;
    for (char& c : out) {
        unsigned char uc = static_cast<unsigned char>(c);
        if (uc >= 33 && uc <= 126) {
            uc = static_cast<unsigned char>(33 + (uc - 33 + 47) % 94);
            c = static_cast<char>(uc);
        }
    }
    return out;
}

bool rot47_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = rot47_encode(sample);
    std::string decoded = rot47_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
