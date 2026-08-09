#include "bit_pack_bools.hpp"
#include "../core/sample.hpp"
#include <sstream>
#include <iomanip>

namespace codecs {

std::string bit_pack_bools_encode(const std::string& input) {
    std::ostringstream header;
    header << std::setw(6) << std::setfill('0') << input.size();
    std::string packed;
    unsigned char cur = 0; int count = 0;
    for (char c : input) {
        cur = static_cast<unsigned char>((cur << 1) | (c == '1' ? 1 : 0));
        ++count;
        if (count == 8) { packed += static_cast<char>(cur); cur = 0; count = 0; }
    }
    if (count > 0) { cur = static_cast<unsigned char>(cur << (8 - count)); packed += static_cast<char>(cur); }
    return header.str() + packed;
}

std::string bit_pack_bools_decode(const std::string& input) {
    std::size_t bit_count = static_cast<std::size_t>(std::stoul(input.substr(0, 6)));
    std::string packed = input.substr(6);
    std::string out;
    out.reserve(bit_count);
    for (unsigned char byte : packed) {
        for (int i = 7; i >= 0 && out.size() < bit_count; --i) {
            out += ((byte >> i) & 1) ? '1' : '0';
        }
    }
    return out;
}

bool bit_pack_bools_verify() {
    std::string sample = core::sample_generate_bitstring(1);
    std::string encoded = bit_pack_bools_encode(sample);
    std::string decoded = bit_pack_bools_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
