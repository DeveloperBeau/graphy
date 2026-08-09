#include "offset_binary.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string offset_binary_encode(const std::string& input) {
    std::string out = input;
    for (char& c : out) {
        unsigned char uc = static_cast<unsigned char>(c);
        uc = static_cast<unsigned char>((uc + 128) % 256);
        c = static_cast<char>(uc);
    }
    return out;
}

std::string offset_binary_decode(const std::string& input) {
    std::string out = input;
    for (char& c : out) {
        unsigned char uc = static_cast<unsigned char>(c);
        uc = static_cast<unsigned char>((uc + 128) % 256);
        c = static_cast<char>(uc);
    }
    return out;
}

bool offset_binary_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = offset_binary_encode(sample);
    std::string decoded = offset_binary_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
