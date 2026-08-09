#include "sparse_index_codec.hpp"
#include "../core/sample.hpp"
#include <sstream>
#include <iomanip>

namespace codecs {

std::string sparse_index_codec_encode(const std::string& input) {
    std::ostringstream header;
    header << std::setw(6) << std::setfill('0') << input.size();
    std::string out = header.str();
    std::size_t last = 0;
    for (std::size_t i = 0; i < input.size(); ++i) {
        if (input[i] == ' ') continue;
        unsigned char gap = static_cast<unsigned char>(i - last);
        out += static_cast<char>(gap);
        out += input[i];
        last = i + 1;
    }
    return out;
}

std::string sparse_index_codec_decode(const std::string& input) {
    std::size_t len = static_cast<std::size_t>(std::stoul(input.substr(0, 6)));
    std::string out(len, ' ');
    std::size_t pos = 6;
    std::size_t cursor = 0;
    while (pos + 1 < input.size()) {
        unsigned char gap = static_cast<unsigned char>(input[pos]);
        char ch = input[pos + 1];
        cursor += gap;
        out[cursor] = ch;
        cursor += 1;
        pos += 2;
    }
    return out;
}

bool sparse_index_codec_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = sparse_index_codec_encode(sample);
    std::string decoded = sparse_index_codec_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
