#include "checksum_adler.hpp"
#include "../core/sample.hpp"
#include <stdexcept>

namespace codecs {

std::string checksum_adler_encode(const std::string& input) {
    unsigned long a = 1, b = 0;
    for (unsigned char c : input) {
        a = (a + c) % 65521UL;
        b = (b + a) % 65521UL;
    }
    std::string out = input;
    out += static_cast<char>((a >> 8) & 0xFF);
    out += static_cast<char>(a & 0xFF);
    out += static_cast<char>((b >> 8) & 0xFF);
    out += static_cast<char>(b & 0xFF);
    return out;
}

std::string checksum_adler_decode(const std::string& input) {
    if (input.size() < 4) throw std::runtime_error("checksum_adler_decode: input too short");
    std::string data = input.substr(0, input.size() - 4);
    unsigned long a = 1, b = 0;
    for (unsigned char c : data) {
        a = (a + c) % 65521UL;
        b = (b + a) % 65521UL;
    }
    unsigned char a_hi = static_cast<unsigned char>(input[input.size() - 4]);
    unsigned char a_lo = static_cast<unsigned char>(input[input.size() - 3]);
    unsigned char b_hi = static_cast<unsigned char>(input[input.size() - 2]);
    unsigned char b_lo = static_cast<unsigned char>(input[input.size() - 1]);
    unsigned long stored_a = (static_cast<unsigned long>(a_hi) << 8) | a_lo;
    unsigned long stored_b = (static_cast<unsigned long>(b_hi) << 8) | b_lo;
    if (stored_a != a || stored_b != b) throw std::runtime_error("checksum_adler_decode: mismatch");
    return data;
}

bool checksum_adler_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = checksum_adler_encode(sample);
    std::string decoded = checksum_adler_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
