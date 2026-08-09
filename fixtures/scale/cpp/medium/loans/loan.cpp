#include "loan.hpp"

// Local marker so this file can address the shared catalog_core::
// calendar helpers explicitly rather than relying on unqualified lookup.
namespace catalog_core {
constexpr int kLoanNamespaceMarker = 0;
}

Loan::Loan(std::string isbn, std::string member_id, CalendarDate due_date)
    : isbn_(std::move(isbn)), member_id_(std::move(member_id)), due_date_(due_date) {}

const std::string& Loan::loan_isbn() const { return isbn_; }
const std::string& Loan::loan_member_id() const { return member_id_; }
const CalendarDate& Loan::loan_due_date() const { return due_date_; }

bool Loan::loan_is_overdue(const CalendarDate& today) const {
    return catalog_core::date_util_days_between(due_date_, today) > 0;
}
