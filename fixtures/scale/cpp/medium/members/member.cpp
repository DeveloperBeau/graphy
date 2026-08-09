#include "member.hpp"

Member::Member(std::string member_id, std::string full_name)
    : member_id_(std::move(member_id)), full_name_(std::move(full_name)) {}

const std::string& Member::member_id() const { return member_id_; }
const std::string& Member::member_full_name() const { return full_name_; }

void Member::member_set_active(bool active) { active_ = active; }
bool Member::member_is_active() const { return active_; }
