#include "waitlist_manager.hpp"

Reservation WaitlistManager::waitlist_manager_enqueue(const std::string& isbn, const std::string& member_id) {
    int position = waitlist_manager_length(isbn) + 1;
    Reservation reservation(isbn, member_id, position);
    reservations_.push_back(reservation);
    return reservation;
}

int WaitlistManager::waitlist_manager_length(const std::string& isbn) const {
    int count = 0;
    for (const Reservation& reservation : reservations_) {
        if (reservation.reservation_isbn() == isbn) ++count;
    }
    return count;
}
