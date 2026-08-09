#include "keyword_substitution.hpp"
#include "../core/sample.hpp"
#include <cctype>

namespace codecs {

std::string keyword_substitution_encode(const std::string& input) {
    static const std::string dst = "QWERTYUIOPASDFGHJKLZXCVBNM";
    std::string out = input;
    for (char& c : out) {
        if (c >= 'A' && c <= 'Z') {
            c = dst[static_cast<std::size_t>(c - 'A')];
        } else if (c >= 'a' && c <= 'z') {
            c = static_cast<char>(std::tolower(static_cast<unsigned char>(dst[static_cast<std::size_t>(c - 'a')])));
        }
    }
    return out;
}

std::string keyword_substitution_decode(const std::string& input) {
    static const std::string src = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    static const std::string dst = "QWERTYUIOPASDFGHJKLZXCVBNM";
    std::string out = input;
    for (char& c : out) {
        if (c >= 'A' && c <= 'Z') {
            std::size_t idx = dst.find(c);
            c = src[idx];
        } else if (c >= 'a' && c <= 'z') {
            char upper = static_cast<char>(std::toupper(static_cast<unsigned char>(c)));
            std::size_t idx = dst.find(upper);
            c = static_cast<char>(std::tolower(static_cast<unsigned char>(src[idx])));
        }
    }
    return out;
}

bool keyword_substitution_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = keyword_substitution_encode(sample);
    std::string decoded = keyword_substitution_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
