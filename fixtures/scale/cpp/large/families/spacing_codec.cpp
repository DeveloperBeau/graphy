#include "spacing_codec.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string spacing_codec_encode(const std::string& input) {
    std::string out;
    for (std::size_t i = 0; i < input.size(); ++i) {
        out += input[i];
        out += '\x01';
    }
    return out;
}

std::string spacing_codec_decode(const std::string& input) {
    std::string out;
    for (std::size_t i = 0; i < input.size(); i += 2) {
        out += input[i];
    }
    return out;
}

bool spacing_codec_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = spacing_codec_encode(sample);
    std::string decoded = spacing_codec_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
