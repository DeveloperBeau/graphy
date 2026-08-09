#pragma once
#include <string>

// Tracks the physical wear of a book copy over time.
enum class BookCondition { New, Good, Worn, Damaged };

std::string condition_tracker_label(BookCondition condition);
BookCondition condition_tracker_downgrade(BookCondition condition);
