#include "byte_reverse.hpp"
#include "../core/sample.hpp"
#include <algorithm>

namespace codecs {

std::string byte_reverse_encode(const std::string& input) {
    std::string out = input;
    std::reverse(out.begin(), out.end());
    return out;
}

std::string byte_reverse_decode(const std::string& input) {
    std::string out = input;
    std::reverse(out.begin(), out.end());
    return out;
}

bool byte_reverse_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = byte_reverse_encode(sample);
    std::string decoded = byte_reverse_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
