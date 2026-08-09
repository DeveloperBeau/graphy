#include "json_string_escape.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string json_string_escape_encode(const std::string& input) {
    std::string out;
    for (char c : input) {
        switch (c) {
            case '"': out += "\\\""; break;
            case '\\': out += "\\\\"; break;
            case '\n': out += "\\n"; break;
            case '\t': out += "\\t"; break;
            default: out += c; break;
        }
    }
    return out;
}

std::string json_string_escape_decode(const std::string& input) {
    std::string out;
    for (std::size_t i = 0; i < input.size(); ++i) {
        if (input[i] == '\\' && i + 1 < input.size()) {
            char next = input[i + 1];
            if (next == '"') { out += '"'; ++i; }
            else if (next == '\\') { out += '\\'; ++i; }
            else if (next == 'n') { out += '\n'; ++i; }
            else if (next == 't') { out += '\t'; ++i; }
            else { out += input[i]; }
        } else {
            out += input[i];
        }
    }
    return out;
}

bool json_string_escape_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = json_string_escape_encode(sample);
    std::string decoded = json_string_escape_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
