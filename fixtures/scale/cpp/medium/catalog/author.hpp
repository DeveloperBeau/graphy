#pragma once
#include <string>
#include <vector>

// Tracks an author's name and the ISBNs of books they have written.
class Author {
public:
    explicit Author(std::string name);

    void author_add_isbn(const std::string& isbn);
    const std::string& author_name() const;
    int author_book_count() const;

private:
    std::string name_;
    std::vector<std::string> isbns_;
};
