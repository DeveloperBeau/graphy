#include "bcd_encoding.hpp"
#include "../core/sample.hpp"
#include <sstream>
#include <iomanip>

namespace codecs {

std::string bcd_encoding_encode(const std::string& input) {
    std::ostringstream header;
    header << std::setw(4) << std::setfill('0') << input.size();
    std::string packed;
    for (std::size_t i = 0; i < input.size(); i += 2) {
        unsigned char hi = static_cast<unsigned char>(input[i] - '0');
        unsigned char lo = (i + 1 < input.size()) ? static_cast<unsigned char>(input[i + 1] - '0') : 0;
        packed += static_cast<char>((hi << 4) | lo);
    }
    return header.str() + packed;
}

std::string bcd_encoding_decode(const std::string& input) {
    std::size_t len = static_cast<std::size_t>(std::stoul(input.substr(0, 4)));
    std::string packed = input.substr(4);
    std::string out;
    for (unsigned char byte : packed) {
        unsigned char hi = static_cast<unsigned char>((byte >> 4) & 0x0F);
        unsigned char lo = static_cast<unsigned char>(byte & 0x0F);
        if (out.size() < len) out += static_cast<char>('0' + hi);
        if (out.size() < len) out += static_cast<char>('0' + lo);
    }
    return out;
}

bool bcd_encoding_verify() {
    std::string sample = core::sample_generate_digits(1);
    std::string encoded = bcd_encoding_encode(sample);
    std::string decoded = bcd_encoding_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
