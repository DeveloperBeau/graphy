#include "checksum_parity.hpp"
#include "../core/sample.hpp"
#include <stdexcept>

namespace codecs {

std::string checksum_parity_encode(const std::string& input) {
    unsigned char parity = 0;
    for (char c : input) parity ^= static_cast<unsigned char>(c);
    return input + static_cast<char>(parity);
}

std::string checksum_parity_decode(const std::string& input) {
    if (input.empty()) throw std::runtime_error("checksum_parity_decode: empty input");
    std::string data = input.substr(0, input.size() - 1);
    unsigned char parity = 0;
    for (char c : data) parity ^= static_cast<unsigned char>(c);
    unsigned char stored = static_cast<unsigned char>(input.back());
    if (parity != stored) throw std::runtime_error("checksum_parity_decode: parity mismatch");
    return data;
}

bool checksum_parity_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = checksum_parity_encode(sample);
    std::string decoded = checksum_parity_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
