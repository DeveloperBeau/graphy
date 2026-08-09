#include "notification_service.hpp"
#include <iostream>

std::string NotificationService::notification_service_build_reminder(const Member& member,
                                                                       const std::string& isbn) const {
    return member.member_full_name() + ", please return " + isbn;
}

void NotificationService::notification_service_send(const Member& member, const std::string& isbn) const {
    std::cout << notification_service_build_reminder(member, isbn) << std::endl;
}
