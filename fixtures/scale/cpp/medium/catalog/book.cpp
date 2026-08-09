#include "book.hpp"
#include "../utils/string_util.hpp"

Book::Book(std::string isbn, std::string title, std::string author_name)
    : isbn_(std::move(isbn)), title_(std::move(title)), author_name_(std::move(author_name)) {}

const std::string& Book::book_isbn() const { return isbn_; }
const std::string& Book::book_title() const { return title_; }
const std::string& Book::book_author_name() const { return author_name_; }

bool Book::book_matches_keyword(const std::string& keyword) const {
    return catalog_core::string_util_contains(title_, keyword)
        || catalog_core::string_util_contains(author_name_, keyword);
}
