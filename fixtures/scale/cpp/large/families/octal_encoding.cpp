#include "octal_encoding.hpp"
#include "../core/sample.hpp"
#include <sstream>
#include <iomanip>

namespace codecs {

std::string octal_encoding_encode(const std::string& input) {
    std::ostringstream out;
    for (unsigned char c : input) {
        out << std::oct << std::setw(3) << std::setfill('0') << static_cast<int>(c);
    }
    return out.str();
}

std::string octal_encoding_decode(const std::string& input) {
    std::string out;
    for (std::size_t i = 0; i + 3 <= input.size(); i += 3) {
        int value = std::stoi(input.substr(i, 3), nullptr, 8);
        out += static_cast<char>(value);
    }
    return out;
}

bool octal_encoding_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = octal_encoding_encode(sample);
    std::string decoded = octal_encoding_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
