#include "checksum_luhn.hpp"
#include "../core/sample.hpp"
#include <stdexcept>

namespace codecs {

std::string checksum_luhn_encode(const std::string& input) {
    int sum = 0;
    bool double_it = true;
    for (auto it = input.rbegin(); it != input.rend(); ++it) {
        int d = *it - '0';
        if (double_it) {
            d *= 2;
            if (d > 9) d -= 9;
        }
        sum += d;
        double_it = !double_it;
    }
    int check = (10 - (sum % 10)) % 10;
    return input + static_cast<char>('0' + check);
}

std::string checksum_luhn_decode(const std::string& input) {
    if (input.empty()) throw std::runtime_error("checksum_luhn_decode: empty input");
    std::string data = input.substr(0, input.size() - 1);
    int sum = 0;
    bool double_it = true;
    for (auto it = data.rbegin(); it != data.rend(); ++it) {
        int d = *it - '0';
        if (double_it) {
            d *= 2;
            if (d > 9) d -= 9;
        }
        sum += d;
        double_it = !double_it;
    }
    int check = (10 - (sum % 10)) % 10;
    char stored = input.back();
    if (static_cast<char>('0' + check) != stored) throw std::runtime_error("checksum_luhn_decode: mismatch");
    return data;
}

bool checksum_luhn_verify() {
    std::string sample = core::sample_generate_digits(1);
    std::string encoded = checksum_luhn_encode(sample);
    std::string decoded = checksum_luhn_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
