#include "baudot_code.hpp"
#include "../core/sample.hpp"
#include <sstream>
#include <iomanip>

namespace codecs {

std::string baudot_code_encode(const std::string& input) {
    std::ostringstream header;
    header << std::setw(6) << std::setfill('0') << input.size();
    std::string packed;
    unsigned int buffer = 0;
    int bits = 0;
    for (char c : input) {
        unsigned int code = static_cast<unsigned int>(c - 'A');
        buffer = (buffer << 5) | code;
        bits += 5;
        while (bits >= 8) {
            packed += static_cast<char>((buffer >> (bits - 8)) & 0xFF);
            bits -= 8;
        }
        buffer &= (bits == 0) ? 0u : ((1u << bits) - 1);
    }
    if (bits > 0) {
        packed += static_cast<char>((buffer << (8 - bits)) & 0xFF);
    }
    return header.str() + packed;
}

std::string baudot_code_decode(const std::string& input) {
    std::size_t char_count = static_cast<std::size_t>(std::stoul(input.substr(0, 6)));
    std::string packed = input.substr(6);
    std::string out;
    unsigned int buffer = 0;
    int bits = 0;
    for (unsigned char byte : packed) {
        buffer = (buffer << 8) | byte;
        bits += 8;
        while (bits >= 5 && out.size() < char_count) {
            unsigned int code = (buffer >> (bits - 5)) & 0x1F;
            out += static_cast<char>('A' + code);
            bits -= 5;
        }
        buffer &= (bits == 0) ? 0u : ((1u << bits) - 1);
    }
    return out;
}

bool baudot_code_verify() {
    std::string sample = core::sample_generate_uppercase_letters(1);
    std::string encoded = baudot_code_encode(sample);
    std::string decoded = baudot_code_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
