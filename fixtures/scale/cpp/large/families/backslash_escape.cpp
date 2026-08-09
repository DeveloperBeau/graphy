#include "backslash_escape.hpp"
#include "../core/sample.hpp"
#include <sstream>
#include <iomanip>

namespace codecs {

std::string backslash_escape_encode(const std::string& input) {
    std::ostringstream out;
    for (unsigned char c : input) {
        if (c == '\\') {
            out << "\\\\";
        } else if (c < 32) {
            out << "\\x" << std::hex << std::setw(2) << std::setfill('0') << static_cast<int>(c) << std::dec;
        } else {
            out << static_cast<char>(c);
        }
    }
    return out.str();
}

std::string backslash_escape_decode(const std::string& input) {
    std::string out;
    for (std::size_t i = 0; i < input.size(); ++i) {
        if (input[i] == '\\' && i + 1 < input.size()) {
            if (input[i + 1] == '\\') { out += '\\'; i += 1; }
            else if (input[i + 1] == 'x' && i + 3 < input.size()) {
                int value = std::stoi(input.substr(i + 2, 2), nullptr, 16);
                out += static_cast<char>(value);
                i += 3;
            } else {
                out += input[i];
            }
        } else {
            out += input[i];
        }
    }
    return out;
}

bool backslash_escape_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = backslash_escape_encode(sample);
    std::string decoded = backslash_escape_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
