#include "loan_ledger.hpp"

void LoanLedger::loan_ledger_record(const Loan& loan) {
    loans_.push_back(loan);
}

std::vector<Loan> LoanLedger::loan_ledger_for_member(const std::string& member_id) const {
    std::vector<Loan> result;
    for (const Loan& loan : loans_) {
        if (loan.loan_member_id() == member_id) result.push_back(loan);
    }
    return result;
}

int LoanLedger::loan_ledger_total_count() const {
    return static_cast<int>(loans_.size());
}
