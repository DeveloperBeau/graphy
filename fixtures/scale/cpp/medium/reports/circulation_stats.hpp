#pragma once
#include "../loans/loan_ledger.hpp"

// Simple circulation metrics derived from the loan ledger.
double circulation_stats_average_per_member(const LoanLedger& ledger, int member_count);
