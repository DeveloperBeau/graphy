#pragma once
#include <string>

// A hold placed by a member on a book that is currently checked out.
class Reservation {
public:
    Reservation(std::string isbn, std::string member_id, int queue_position);

    const std::string& reservation_isbn() const;
    const std::string& reservation_member_id() const;
    int reservation_queue_position() const;

private:
    std::string isbn_;
    std::string member_id_;
    int queue_position_;
};
