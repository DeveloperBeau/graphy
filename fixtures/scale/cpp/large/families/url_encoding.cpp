#include "url_encoding.hpp"
#include "../core/sample.hpp"
#include <sstream>
#include <iomanip>
#include <cctype>

namespace codecs {

std::string url_encoding_encode(const std::string& input) {
    std::ostringstream out;
    for (unsigned char c : input) {
        if (std::isalnum(c) || c == '-' || c == '_' || c == '.' || c == '~') {
            out << static_cast<char>(c);
        } else {
            out << '%' << std::uppercase << std::hex << std::setw(2) << std::setfill('0')
                << static_cast<int>(c) << std::nouppercase << std::dec;
        }
    }
    return out.str();
}

std::string url_encoding_decode(const std::string& input) {
    std::string out;
    for (std::size_t i = 0; i < input.size(); ++i) {
        if (input[i] == '%' && i + 2 < input.size()) {
            int value = std::stoi(input.substr(i + 1, 2), nullptr, 16);
            out += static_cast<char>(value);
            i += 2;
        } else {
            out += input[i];
        }
    }
    return out;
}

bool url_encoding_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = url_encoding_encode(sample);
    std::string decoded = url_encoding_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
