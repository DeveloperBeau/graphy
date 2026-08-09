#pragma once
#include <string>

// A library patron who can borrow books.
class Member {
public:
    Member(std::string member_id, std::string full_name);

    const std::string& member_id() const;
    const std::string& member_full_name() const;
    void member_set_active(bool active);
    bool member_is_active() const;

private:
    std::string member_id_;
    std::string full_name_;
    bool active_ = true;
};
