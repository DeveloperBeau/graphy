#include "rot5.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string rot5_encode(const std::string& input) {
    std::string out = input;
    for (char& c : out) {
        if (c >= '0' && c <= '9') c = static_cast<char>('0' + (c - '0' + 5) % 10);
    }
    return out;
}

std::string rot5_decode(const std::string& input) {
    std::string out = input;
    for (char& c : out) {
        if (c >= '0' && c <= '9') c = static_cast<char>('0' + (c - '0' + 5) % 10);
    }
    return out;
}

bool rot5_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = rot5_encode(sample);
    std::string decoded = rot5_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
