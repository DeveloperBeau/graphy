#include "reservation.hpp"

Reservation::Reservation(std::string isbn, std::string member_id, int queue_position)
    : isbn_(std::move(isbn)), member_id_(std::move(member_id)), queue_position_(queue_position) {}

const std::string& Reservation::reservation_isbn() const { return isbn_; }
const std::string& Reservation::reservation_member_id() const { return member_id_; }
int Reservation::reservation_queue_position() const { return queue_position_; }
