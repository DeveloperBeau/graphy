#pragma once
#include <string>

// Minimal calendar-day helpers shared across the catalog system.
struct CalendarDate {
    int year;
    int month;
    int day;
};

// Every free function shared across catalog subsystems lives in
// catalog_core so cross-file callers can reach it with an explicit,
// resolvable qualified call (catalog_core::date_util_days_between(...)).
namespace catalog_core {

int date_util_day_number(const CalendarDate& date);
int date_util_days_between(const CalendarDate& a, const CalendarDate& b);
std::string date_util_format(const CalendarDate& date);

} // namespace catalog_core
