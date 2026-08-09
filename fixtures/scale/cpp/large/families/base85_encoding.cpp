#include "base85_encoding.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string base85_encoding_encode(const std::string& input) {
    std::string out;
    for (unsigned char c : input) {
        unsigned char hi = static_cast<unsigned char>(c / 85);
        unsigned char lo = static_cast<unsigned char>(c % 85);
        out += static_cast<char>(33 + hi);
        out += static_cast<char>(33 + lo);
    }
    return out;
}

std::string base85_encoding_decode(const std::string& input) {
    std::string out;
    for (std::size_t i = 0; i + 1 < input.size(); i += 2) {
        int hi = static_cast<unsigned char>(input[i]) - 33;
        int lo = static_cast<unsigned char>(input[i + 1]) - 33;
        out += static_cast<char>(hi * 85 + lo);
    }
    return out;
}

bool base85_encoding_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = base85_encoding_encode(sample);
    std::string decoded = base85_encoding_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
