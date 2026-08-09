#pragma once
#include <string>

// A single catalog entry describing one physical or digital book.
class Book {
public:
    Book(std::string isbn, std::string title, std::string author_name);

    const std::string& book_isbn() const;
    const std::string& book_title() const;
    const std::string& book_author_name() const;
    bool book_matches_keyword(const std::string& keyword) const;

private:
    std::string isbn_;
    std::string title_;
    std::string author_name_;
};
