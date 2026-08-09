#pragma once
#include <vector>
#include <string>
#include "member.hpp"

// Owns every registered member and supports lookup by identifier.
class MemberRegistry {
public:
    void member_registry_add(const Member& member);
    const Member* member_registry_find(const std::string& member_id) const;
    int member_registry_active_count() const;

private:
    std::vector<Member> members_;
};
