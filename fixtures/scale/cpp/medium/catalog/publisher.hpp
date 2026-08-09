#pragma once
#include <string>

// A publishing house associated with catalog entries.
class Publisher {
public:
    Publisher(std::string name, int founding_year);

    const std::string& publisher_name() const;
    int publisher_age(int current_year) const;

private:
    std::string name_;
    int founding_year_;
};
