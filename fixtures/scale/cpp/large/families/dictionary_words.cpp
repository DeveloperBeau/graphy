#include "dictionary_words.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string dictionary_words_encode(const std::string& input) {
    struct Entry { const char* phrase; char token; };
    static const Entry table[] = {
        {"the", '\x10'}, {"and", '\x11'}, {"of", '\x12'}, {"to", '\x13'}
    };
    std::string out = input;
    for (const Entry& e : table) {
        std::string phrase = e.phrase;
        std::size_t pos = 0;
        while ((pos = out.find(phrase, pos)) != std::string::npos) {
            out.replace(pos, phrase.size(), std::string(1, e.token));
            pos += 1;
        }
    }
    return out;
}

std::string dictionary_words_decode(const std::string& input) {
    struct Entry { const char* phrase; char token; };
    static const Entry table[] = {
        {"the", '\x10'}, {"and", '\x11'}, {"of", '\x12'}, {"to", '\x13'}
    };
    std::string out = input;
    for (const Entry& e : table) {
        std::string phrase = e.phrase;
        std::size_t pos = 0;
        while ((pos = out.find(e.token, pos)) != std::string::npos) {
            out.replace(pos, 1, phrase);
            pos += phrase.size();
        }
    }
    return out;
}

bool dictionary_words_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = dictionary_words_encode(sample);
    std::string decoded = dictionary_words_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
