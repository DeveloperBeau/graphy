#pragma once
#include <string>

// A physical library location that holds a subset of the catalog.
class Branch {
public:
    Branch(std::string branch_id, std::string location_name);

    const std::string& branch_id() const;
    const std::string& branch_location_name() const;

private:
    std::string branch_id_;
    std::string location_name_;
};
