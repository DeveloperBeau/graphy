#pragma once
#include "../utils/date_util.hpp"
#include "loan.hpp"

// Computes a fresh due date when a member renews an existing loan.
Loan renewal_service_extend(const Loan& loan, int extra_days);
