#include "overdue_report.hpp"

std::vector<Loan> overdue_report_build(const LoanLedger& ledger, const std::vector<Loan>& active_loans,
                                        const CalendarDate& today) {
    (void)ledger;
    std::vector<Loan> overdue;
    for (const Loan& loan : active_loans) {
        if (loan.loan_is_overdue(today)) overdue.push_back(loan);
    }
    return overdue;
}
