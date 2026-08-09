#include "quoted_printable.hpp"
#include "../core/sample.hpp"
#include <sstream>
#include <iomanip>

namespace codecs {

std::string quoted_printable_encode(const std::string& input) {
    std::ostringstream out;
    for (unsigned char c : input) {
        if (c == '=' || c < 32 || c > 126) {
            out << '=' << std::uppercase << std::hex << std::setw(2) << std::setfill('0')
                << static_cast<int>(c) << std::nouppercase << std::dec;
        } else {
            out << static_cast<char>(c);
        }
    }
    return out.str();
}

std::string quoted_printable_decode(const std::string& input) {
    std::string out;
    for (std::size_t i = 0; i < input.size(); ++i) {
        if (input[i] == '=' && i + 2 < input.size()) {
            std::string hex_digits = input.substr(i + 1, 2);
            int value = std::stoi(hex_digits, nullptr, 16);
            out += static_cast<char>(value);
            i += 2;
        } else {
            out += input[i];
        }
    }
    return out;
}

bool quoted_printable_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = quoted_printable_encode(sample);
    std::string decoded = quoted_printable_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
