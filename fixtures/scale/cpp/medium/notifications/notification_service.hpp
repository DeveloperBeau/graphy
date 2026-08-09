#pragma once
#include <string>
#include "../members/member.hpp"

// Builds and "sends" (prints) reminders to members about due books.
class NotificationService {
public:
    std::string notification_service_build_reminder(const Member& member, const std::string& isbn) const;
    void notification_service_send(const Member& member, const std::string& isbn) const;
};
