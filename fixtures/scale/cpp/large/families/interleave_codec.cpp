#include "interleave_codec.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string interleave_codec_encode(const std::string& input) {
    std::string evens, odds;
    for (std::size_t i = 0; i < input.size(); ++i) {
        if (i % 2 == 0) evens += input[i]; else odds += input[i];
    }
    return evens + odds;
}

std::string interleave_codec_decode(const std::string& input) {
    std::size_t total = input.size();
    std::size_t evens_count = (total + 1) / 2;
    std::string out(total, '\0');
    for (std::size_t i = 0; i < evens_count; ++i) out[2 * i] = input[i];
    for (std::size_t i = evens_count; i < total; ++i) out[2 * (i - evens_count) + 1] = input[i];
    return out;
}

bool interleave_codec_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = interleave_codec_encode(sample);
    std::string decoded = interleave_codec_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
