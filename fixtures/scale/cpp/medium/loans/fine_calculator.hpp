#pragma once
#include "../utils/date_util.hpp"
#include "loan.hpp"

namespace catalog_core {

// Turns an overdue loan into an amount owed.
double fine_calculator_amount_owed(const Loan& loan, const CalendarDate& today, double daily_rate);

} // namespace catalog_core
