#include "morse_code.hpp"
#include "../core/sample.hpp"

namespace codecs {

std::string morse_code_encode(const std::string& input) {
    static const char* codes[36] = {
        ".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",
        ".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--..",
        "-----",".----","..---","...--","....-",".....","-....","--...","---..","----."
    };
    std::string out;
    for (std::size_t i = 0; i < input.size(); ++i) {
        char c = input[i];
        int idx = (c >= 'A' && c <= 'Z') ? (c - 'A') : (26 + (c - '0'));
        if (i > 0) out += ' ';
        out += codes[idx];
    }
    return out;
}

std::string morse_code_decode(const std::string& input) {
    static const char* codes[36] = {
        ".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",
        ".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--..",
        "-----",".----","..---","...--","....-",".....","-....","--...","---..","----."
    };
    std::string out;
    std::size_t pos = 0;
    while (pos < input.size()) {
        std::size_t next = input.find(' ', pos);
        std::string token = (next == std::string::npos) ? input.substr(pos) : input.substr(pos, next - pos);
        for (int idx = 0; idx < 36; ++idx) {
            if (token == codes[idx]) {
                out += static_cast<char>(idx < 26 ? ('A' + idx) : ('0' + (idx - 26)));
                break;
            }
        }
        if (next == std::string::npos) break;
        pos = next + 1;
    }
    return out;
}

bool morse_code_verify() {
    std::string sample = core::sample_generate_uppercase(1);
    std::string encoded = morse_code_encode(sample);
    std::string decoded = morse_code_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
