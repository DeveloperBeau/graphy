#include "checksum_fletcher.hpp"
#include "../core/sample.hpp"
#include <stdexcept>

namespace codecs {

std::string checksum_fletcher_encode(const std::string& input) {
    unsigned int sum1 = 0, sum2 = 0;
    for (unsigned char c : input) {
        sum1 = (sum1 + c) % 255;
        sum2 = (sum2 + sum1) % 255;
    }
    std::string out = input;
    out += static_cast<char>(sum1);
    out += static_cast<char>(sum2);
    return out;
}

std::string checksum_fletcher_decode(const std::string& input) {
    if (input.size() < 2) throw std::runtime_error("checksum_fletcher_decode: input too short");
    std::string data = input.substr(0, input.size() - 2);
    unsigned int sum1 = 0, sum2 = 0;
    for (unsigned char c : data) {
        sum1 = (sum1 + c) % 255;
        sum2 = (sum2 + sum1) % 255;
    }
    unsigned char s1 = static_cast<unsigned char>(input[input.size() - 2]);
    unsigned char s2 = static_cast<unsigned char>(input[input.size() - 1]);
    if (s1 != sum1 || s2 != sum2) throw std::runtime_error("checksum_fletcher_decode: mismatch");
    return data;
}

bool checksum_fletcher_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = checksum_fletcher_encode(sample);
    std::string decoded = checksum_fletcher_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
