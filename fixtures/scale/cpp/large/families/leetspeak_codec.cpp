#include "leetspeak_codec.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string leetspeak_codec_encode(const std::string& input) {
    std::string out = input;
    for (char& c : out) {
        switch (c) {
            case 'a': c = '4'; break;
            case 'e': c = '3'; break;
            case 'i': c = '1'; break;
            case 'o': c = '0'; break;
            case 's': c = '5'; break;
            default: break;
        }
    }
    return out;
}

std::string leetspeak_codec_decode(const std::string& input) {
    std::string out = input;
    for (char& c : out) {
        switch (c) {
            case '4': c = 'a'; break;
            case '3': c = 'e'; break;
            case '1': c = 'i'; break;
            case '0': c = 'o'; break;
            case '5': c = 's'; break;
            default: break;
        }
    }
    return out;
}

bool leetspeak_codec_verify() {
    std::string sample = core::sample_generate_letters(1);
    std::string encoded = leetspeak_codec_encode(sample);
    std::string decoded = leetspeak_codec_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
