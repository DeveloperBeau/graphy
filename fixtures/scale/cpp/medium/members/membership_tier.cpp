#include "membership_tier.hpp"

std::string membership_tier_label(MembershipLevel level) {
    switch (level) {
        case MembershipLevel::Premium: return "premium";
        case MembershipLevel::Student: return "student";
        default: return "standard";
    }
}

int membership_tier_loan_limit(MembershipLevel level) {
    switch (level) {
        case MembershipLevel::Premium: return 10;
        case MembershipLevel::Student: return 3;
        default: return 5;
    }
}
