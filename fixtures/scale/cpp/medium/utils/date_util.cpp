#include "date_util.hpp"
#include <sstream>
#include <iomanip>

namespace catalog_core {

int date_util_day_number(const CalendarDate& date) {
    return date.year * 372 + date.month * 31 + date.day;
}

int date_util_days_between(const CalendarDate& a, const CalendarDate& b) {
    return date_util_day_number(b) - date_util_day_number(a);
}

std::string date_util_format(const CalendarDate& date) {
    std::ostringstream out;
    out << date.year << "-" << std::setw(2) << std::setfill('0') << date.month
        << "-" << std::setw(2) << std::setfill('0') << date.day;
    return out.str();
}

} // namespace catalog_core
