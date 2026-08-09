#include "publisher.hpp"

Publisher::Publisher(std::string name, int founding_year)
    : name_(std::move(name)), founding_year_(founding_year) {}

const std::string& Publisher::publisher_name() const { return name_; }

int Publisher::publisher_age(int current_year) const {
    return current_year - founding_year_;
}
