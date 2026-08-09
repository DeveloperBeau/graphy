#pragma once
#include <string>

namespace core {

// Deterministic sample generators. Each codec family picks the alphabet
// that matches what it can losslessly round trip.
std::string sample_generate_text(int variant);
std::string sample_generate_digits(int variant);
std::string sample_generate_letters(int variant);
std::string sample_generate_bitstring(int variant);
std::string sample_generate_uppercase(int variant);
std::string sample_generate_uppercase_letters(int variant);

} // namespace core
