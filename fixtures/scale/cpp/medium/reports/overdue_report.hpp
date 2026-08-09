#pragma once
#include <vector>
#include "../loans/loan_ledger.hpp"
#include "../utils/date_util.hpp"

// Builds the list of loans that are currently overdue.
std::vector<Loan> overdue_report_build(const LoanLedger& ledger, const std::vector<Loan>& active_loans,
                                        const CalendarDate& today);
