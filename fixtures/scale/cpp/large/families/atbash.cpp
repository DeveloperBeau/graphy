#include "atbash.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string atbash_encode(const std::string& input) {
    std::string out = input;
    for (char& c : out) {
        if (c >= 'a' && c <= 'z') c = static_cast<char>('a' + ('z' - c));
        else if (c >= 'A' && c <= 'Z') c = static_cast<char>('A' + ('Z' - c));
    }
    return out;
}

std::string atbash_decode(const std::string& input) {
    std::string out = input;
    for (char& c : out) {
        if (c >= 'a' && c <= 'z') c = static_cast<char>('a' + ('z' - c));
        else if (c >= 'A' && c <= 'Z') c = static_cast<char>('A' + ('Z' - c));
    }
    return out;
}

bool atbash_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = atbash_encode(sample);
    std::string decoded = atbash_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
