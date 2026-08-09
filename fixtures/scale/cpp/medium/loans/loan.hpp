#pragma once
#include <string>
#include "../utils/date_util.hpp"

// A single active or historical checkout of a book by a member.
class Loan {
public:
    Loan(std::string isbn, std::string member_id, CalendarDate due_date);

    const std::string& loan_isbn() const;
    const std::string& loan_member_id() const;
    const CalendarDate& loan_due_date() const;
    bool loan_is_overdue(const CalendarDate& today) const;

private:
    std::string isbn_;
    std::string member_id_;
    CalendarDate due_date_;
};
