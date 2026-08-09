#include "catalog_store.hpp"

void CatalogStore::catalog_store_add_book(const Book& book) {
    books_.push_back(book);
}

const Book* CatalogStore::catalog_store_find_by_isbn(const std::string& isbn) const {
    for (const Book& book : books_) {
        if (book.book_isbn() == isbn) return &book;
    }
    return nullptr;
}

int CatalogStore::catalog_store_size() const {
    return static_cast<int>(books_.size());
}

std::vector<Book> CatalogStore::catalog_store_all() const {
    return books_;
}
