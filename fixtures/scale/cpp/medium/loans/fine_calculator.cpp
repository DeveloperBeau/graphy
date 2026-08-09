#include "fine_calculator.hpp"

namespace catalog_core {

double fine_calculator_amount_owed(const Loan& loan, const CalendarDate& today, double daily_rate) {
    int days_late = catalog_core::date_util_days_between(loan.loan_due_date(), today);
    if (days_late <= 0) return 0.0;
    return days_late * daily_rate;
}

} // namespace catalog_core
