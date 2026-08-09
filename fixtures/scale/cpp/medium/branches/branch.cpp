#include "branch.hpp"

Branch::Branch(std::string branch_id, std::string location_name)
    : branch_id_(std::move(branch_id)), location_name_(std::move(location_name)) {}

const std::string& Branch::branch_id() const { return branch_id_; }
const std::string& Branch::branch_location_name() const { return location_name_; }
