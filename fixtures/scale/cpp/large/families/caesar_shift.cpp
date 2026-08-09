#include "caesar_shift.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string caesar_shift_encode(const std::string& input) {
    std::string out = input;
    for (char& c : out) {
        if (c >= 'a' && c <= 'z') c = static_cast<char>('a' + (c - 'a' + 7) % 26);
        else if (c >= 'A' && c <= 'Z') c = static_cast<char>('A' + (c - 'A' + 7) % 26);
    }
    return out;
}

std::string caesar_shift_decode(const std::string& input) {
    std::string out = input;
    for (char& c : out) {
        if (c >= 'a' && c <= 'z') c = static_cast<char>('a' + (c - 'a' + 26 - 7) % 26);
        else if (c >= 'A' && c <= 'Z') c = static_cast<char>('A' + (c - 'A' + 26 - 7) % 26);
    }
    return out;
}

bool caesar_shift_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = caesar_shift_encode(sample);
    std::string decoded = caesar_shift_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
