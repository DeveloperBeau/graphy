#pragma once
#include <string>

// Produces short, stable identifiers for catalog entities.
class IdGenerator {
public:
    explicit IdGenerator(std::string prefix);
    std::string id_generator_next();

private:
    std::string prefix_;
    int counter_;
};
