#include "condition_tracker.hpp"

std::string condition_tracker_label(BookCondition condition) {
    switch (condition) {
        case BookCondition::New: return "new";
        case BookCondition::Good: return "good";
        case BookCondition::Worn: return "worn";
        default: return "damaged";
    }
}

BookCondition condition_tracker_downgrade(BookCondition condition) {
    switch (condition) {
        case BookCondition::New: return BookCondition::Good;
        case BookCondition::Good: return BookCondition::Worn;
        default: return BookCondition::Damaged;
    }
}
