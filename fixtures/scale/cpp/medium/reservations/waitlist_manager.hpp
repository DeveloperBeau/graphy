#pragma once
#include <vector>
#include "reservation.hpp"

// Keeps the ordered wait list of reservations for every title.
class WaitlistManager {
public:
    Reservation waitlist_manager_enqueue(const std::string& isbn, const std::string& member_id);
    int waitlist_manager_length(const std::string& isbn) const;

private:
    std::vector<Reservation> reservations_;
};
