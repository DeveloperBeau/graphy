#include "bitmap_rle.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string bitmap_rle_encode(const std::string& input) {
    std::string out;
    if (input.empty()) return out;
    out += input[0];
    char cur = input[0];
    unsigned char run = 0;
    for (char c : input) {
        if (c == cur) {
            ++run;
        } else {
            out += static_cast<char>(run);
            cur = c;
            run = 1;
        }
    }
    out += static_cast<char>(run);
    return out;
}

std::string bitmap_rle_decode(const std::string& input) {
    if (input.empty()) return std::string();
    char cur = input[0];
    std::string out;
    for (std::size_t i = 1; i < input.size(); ++i) {
        unsigned char run = static_cast<unsigned char>(input[i]);
        out.append(run, cur);
        cur = (cur == '0') ? '1' : '0';
    }
    return out;
}

bool bitmap_rle_verify() {
    std::string sample = core::sample_generate_bitstring(1);
    std::string encoded = bitmap_rle_encode(sample);
    std::string decoded = bitmap_rle_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
