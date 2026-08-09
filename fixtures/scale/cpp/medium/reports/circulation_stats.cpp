#include "circulation_stats.hpp"

double circulation_stats_average_per_member(const LoanLedger& ledger, int member_count) {
    if (member_count <= 0) return 0.0;
    return static_cast<double>(ledger.loan_ledger_total_count()) / member_count;
}
