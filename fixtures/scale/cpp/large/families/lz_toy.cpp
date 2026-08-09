#include "lz_toy.hpp"
#include "../core/sample.hpp"
#include <algorithm>

namespace codecs {

std::string lz_toy_encode(const std::string& input) {
    std::string out;
    std::size_t i = 0;
    while (i < input.size()) {
        std::size_t best_len = 0, best_dist = 0;
        std::size_t max_len = std::min<std::size_t>(9, input.size() - i);
        for (std::size_t back = 1; back <= i && back <= 255; ++back) {
            std::size_t start = i - back;
            std::size_t len = 0;
            while (len < max_len && input[start + len] == input[i + len]) ++len;
            if (len > best_len) { best_len = len; best_dist = back; }
        }
        if (best_len >= 3) {
            out += '\x01';
            out += static_cast<char>(best_dist);
            out += static_cast<char>(best_len);
            i += best_len;
        } else {
            out += '\x02';
            out += input[i];
            ++i;
        }
    }
    return out;
}

std::string lz_toy_decode(const std::string& input) {
    std::string out;
    std::size_t i = 0;
    while (i < input.size()) {
        unsigned char marker = static_cast<unsigned char>(input[i]);
        if (marker == 0x01) {
            unsigned char dist = static_cast<unsigned char>(input[i + 1]);
            unsigned char len = static_cast<unsigned char>(input[i + 2]);
            std::size_t start = out.size() - dist;
            for (unsigned char k = 0; k < len; ++k) {
                out += out[start + k];
            }
            i += 3;
        } else {
            out += input[i + 1];
            i += 2;
        }
    }
    return out;
}

bool lz_toy_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = lz_toy_encode(sample);
    std::string decoded = lz_toy_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
