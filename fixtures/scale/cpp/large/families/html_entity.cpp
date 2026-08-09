#include "html_entity.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string html_entity_encode(const std::string& input) {
    std::string out;
    for (char c : input) {
        switch (c) {
            case '&': out += "&amp;"; break;
            case '<': out += "&lt;"; break;
            case '>': out += "&gt;"; break;
            case '"': out += "&quot;"; break;
            case '\'': out += "&apos;"; break;
            default: out += c; break;
        }
    }
    return out;
}

std::string html_entity_decode(const std::string& input) {
    std::string out;
    std::size_t i = 0;
    while (i < input.size()) {
        if (input.compare(i, 5, "&amp;") == 0) { out += '&'; i += 5; }
        else if (input.compare(i, 4, "&lt;") == 0) { out += '<'; i += 4; }
        else if (input.compare(i, 4, "&gt;") == 0) { out += '>'; i += 4; }
        else if (input.compare(i, 6, "&quot;") == 0) { out += '"'; i += 6; }
        else if (input.compare(i, 6, "&apos;") == 0) { out += '\''; i += 6; }
        else { out += input[i]; ++i; }
    }
    return out;
}

bool html_entity_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = html_entity_encode(sample);
    std::string decoded = html_entity_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
