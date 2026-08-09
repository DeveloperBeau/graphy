#include "columnar_transposition.hpp"
#include "../core/sample.hpp"
#include <sstream>
#include <iomanip>

namespace codecs {

std::string columnar_transposition_encode(const std::string& input) {
    const int cols = 5;
    std::size_t len = input.size();
    std::size_t rows = (len + static_cast<std::size_t>(cols) - 1) / static_cast<std::size_t>(cols);
    std::string padded = input;
    padded.resize(rows * static_cast<std::size_t>(cols), ' ');
    std::string grid_out;
    for (int c = 0; c < cols; ++c) {
        for (std::size_t r = 0; r < rows; ++r) {
            grid_out += padded[r * static_cast<std::size_t>(cols) + static_cast<std::size_t>(c)];
        }
    }
    std::ostringstream header;
    header << std::setw(4) << std::setfill('0') << len;
    return header.str() + grid_out;
}

std::string columnar_transposition_decode(const std::string& input) {
    const int cols = 5;
    std::size_t len = static_cast<std::size_t>(std::stoi(input.substr(0, 4)));
    std::string grid_in = input.substr(4);
    std::size_t rows = grid_in.size() / static_cast<std::size_t>(cols);
    std::string padded(rows * static_cast<std::size_t>(cols), ' ');
    std::size_t pos = 0;
    for (int c = 0; c < cols; ++c) {
        for (std::size_t r = 0; r < rows; ++r) {
            padded[r * static_cast<std::size_t>(cols) + static_cast<std::size_t>(c)] = grid_in[pos++];
        }
    }
    return padded.substr(0, len);
}

bool columnar_transposition_verify() {
    std::string sample = core::sample_generate_text(1);
    std::string encoded = columnar_transposition_encode(sample);
    std::string decoded = columnar_transposition_decode(encoded);
    return decoded == sample;
}

} // namespace codecs
