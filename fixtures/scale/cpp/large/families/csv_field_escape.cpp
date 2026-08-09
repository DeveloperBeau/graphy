#include "csv_field_escape.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string csv_field_escape_encode(const std::string& input) {
    bool needs_quotes = input.find(',') != std::string::npos || input.find('"') != std::string::npos
                         || input.find('\n') != std::string::npos;
    if (!needs_quotes) return input;
    std::string out = "\"";
    for (char c : input) {
        if (c == '"') out += "\"\"";
        else out += c;
    }
    out += "\"";
    return out;
}

std::string csv_field_escape_decode(const std::string& input) {
    if (input.empty() || input.front() != '"') return input;
    std::string out;
    for (std::size_t i = 1; i + 1 < input.size(); ++i) {
        if (input[i] == '"' && i + 1 < input.size() - 1 && input[i + 1] == '"') {
            out += '"';
            ++i;
        } else if (input[i] == '"') {
            break;
        } else {
            out += input[i];
        }
    }
    return out;
}

bool csv_field_escape_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = csv_field_escape_encode(sample);
    std::string decoded = csv_field_escape_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
