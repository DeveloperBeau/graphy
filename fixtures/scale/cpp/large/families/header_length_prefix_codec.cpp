#include "header_length_prefix_codec.hpp"
#include "../core/sample.hpp"
#include <sstream>
#include <iomanip>

namespace codecs {

std::string header_length_prefix_codec_encode(const std::string& input) {
    std::ostringstream header;
    header << std::setw(6) << std::setfill('0') << input.size();
    return header.str() + input;
}

std::string header_length_prefix_codec_decode(const std::string& input) {
    std::size_t len = static_cast<std::size_t>(std::stoul(input.substr(0, 6)));
    return input.substr(6, len);
}

bool header_length_prefix_codec_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = header_length_prefix_codec_encode(sample);
    std::string decoded = header_length_prefix_codec_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
