#include "checksum_crc8.hpp"
#include "../core/sample.hpp"
#include <stdexcept>

namespace codecs {

std::string checksum_crc8_encode(const std::string& input) {
    unsigned char crc = 0;
    for (unsigned char c : input) {
        crc ^= c;
        for (int bit = 0; bit < 8; ++bit) {
            if (crc & 0x80) crc = static_cast<unsigned char>((crc << 1) ^ 0x07);
            else crc = static_cast<unsigned char>(crc << 1);
        }
    }
    return input + static_cast<char>(crc);
}

std::string checksum_crc8_decode(const std::string& input) {
    if (input.empty()) throw std::runtime_error("checksum_crc8_decode: empty input");
    std::string data = input.substr(0, input.size() - 1);
    unsigned char crc = 0;
    for (unsigned char c : data) {
        crc ^= c;
        for (int bit = 0; bit < 8; ++bit) {
            if (crc & 0x80) crc = static_cast<unsigned char>((crc << 1) ^ 0x07);
            else crc = static_cast<unsigned char>(crc << 1);
        }
    }
    unsigned char stored = static_cast<unsigned char>(input.back());
    if (crc != stored) throw std::runtime_error("checksum_crc8_decode: mismatch");
    return data;
}

bool checksum_crc8_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = checksum_crc8_encode(sample);
    std::string decoded = checksum_crc8_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
