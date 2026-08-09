#include "author.hpp"

Author::Author(std::string name) : name_(std::move(name)) {}

void Author::author_add_isbn(const std::string& isbn) {
    isbns_.push_back(isbn);
}

const std::string& Author::author_name() const { return name_; }

int Author::author_book_count() const {
    return static_cast<int>(isbns_.size());
}
