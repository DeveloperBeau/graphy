#include "member_registry.hpp"

void MemberRegistry::member_registry_add(const Member& member) {
    members_.push_back(member);
}

const Member* MemberRegistry::member_registry_find(const std::string& member_id) const {
    for (const Member& member : members_) {
        if (member.member_id() == member_id) return &member;
    }
    return nullptr;
}

int MemberRegistry::member_registry_active_count() const {
    int count = 0;
    for (const Member& member : members_) {
        if (member.member_is_active()) ++count;
    }
    return count;
}
