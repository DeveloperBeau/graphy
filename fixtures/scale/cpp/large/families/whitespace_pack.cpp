#include "whitespace_pack.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string whitespace_pack_encode(const std::string& input) {
    std::string out;
    std::size_t i = 0;
    while (i < input.size()) {
        if (input[i] == ' ') {
            std::size_t j = i;
            while (j < input.size() && input[j] == ' ' && (j - i) < 255) ++j;
            std::size_t count = j - i;
            if (count >= 2) {
                out += '\x02';
                out += static_cast<char>(count);
            } else {
                out += ' ';
            }
            i = j;
        } else {
            out += input[i];
            ++i;
        }
    }
    return out;
}

std::string whitespace_pack_decode(const std::string& input) {
    std::string out;
    for (std::size_t i = 0; i < input.size(); ++i) {
        if (input[i] == '\x02' && i + 1 < input.size()) {
            unsigned char count = static_cast<unsigned char>(input[i + 1]);
            out.append(count, ' ');
            ++i;
        } else {
            out += input[i];
        }
    }
    return out;
}

bool whitespace_pack_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = whitespace_pack_encode(sample);
    std::string decoded = whitespace_pack_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
