#pragma once
#include <string>

// Membership tiers change how many books a patron may borrow at once.
enum class MembershipLevel { Standard, Premium, Student };

std::string membership_tier_label(MembershipLevel level);
int membership_tier_loan_limit(MembershipLevel level);
