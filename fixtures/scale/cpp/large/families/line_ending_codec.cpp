#include "line_ending_codec.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string line_ending_codec_encode(const std::string& input) {
    std::string out;
    for (char c : input) {
        if (c == '\n') out += "\r\n";
        else out += c;
    }
    return out;
}

std::string line_ending_codec_decode(const std::string& input) {
    std::string out;
    for (std::size_t i = 0; i < input.size(); ++i) {
        if (input[i] == '\r' && i + 1 < input.size() && input[i + 1] == '\n') {
            continue;
        }
        out += input[i];
    }
    return out;
}

bool line_ending_codec_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = line_ending_codec_encode(sample);
    std::string decoded = line_ending_codec_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
