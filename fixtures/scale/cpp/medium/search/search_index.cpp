#include "search_index.hpp"

std::vector<Book> search_index_run(const CatalogStore& store, const SearchQuery& query) {
    std::vector<Book> matches;
    for (const Book& book : store.catalog_store_all()) {
        if (book.book_matches_keyword(query.keyword)) matches.push_back(book);
    }
    return matches;
}
