#pragma once
#include <vector>
#include "loan.hpp"

// Records every loan ever issued so history and reports can query it.
class LoanLedger {
public:
    void loan_ledger_record(const Loan& loan);
    std::vector<Loan> loan_ledger_for_member(const std::string& member_id) const;
    int loan_ledger_total_count() const;

private:
    std::vector<Loan> loans_;
};
