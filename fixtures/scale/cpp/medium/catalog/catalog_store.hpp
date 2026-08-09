#pragma once
#include <vector>
#include <string>
#include "book.hpp"

// The primary in-memory collection of every book known to the system.
class CatalogStore {
public:
    void catalog_store_add_book(const Book& book);
    const Book* catalog_store_find_by_isbn(const std::string& isbn) const;
    int catalog_store_size() const;
    std::vector<Book> catalog_store_all() const;

private:
    std::vector<Book> books_;
};
