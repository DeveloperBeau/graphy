#include "id_generator.hpp"

IdGenerator::IdGenerator(std::string prefix) : prefix_(std::move(prefix)), counter_(0) {}

std::string IdGenerator::id_generator_next() {
    ++counter_;
    return prefix_ + std::to_string(counter_);
}
