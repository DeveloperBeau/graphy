#include "renewal_service.hpp"

Loan renewal_service_extend(const Loan& loan, int extra_days) {
    CalendarDate new_due = loan.loan_due_date();
    new_due.day += extra_days;
    return Loan(loan.loan_isbn(), loan.loan_member_id(), new_due);
}
