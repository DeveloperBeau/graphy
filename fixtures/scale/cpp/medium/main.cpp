#include "catalog/book.hpp"
#include "catalog/catalog_store.hpp"
#include "members/member.hpp"
#include "members/member_registry.hpp"
#include "loans/loan.hpp"
#include "loans/loan_ledger.hpp"
#include "reports/summary_report.hpp"
#include "reports/overdue_report.hpp"
#include "search/search_query.hpp"
#include "search/search_index.hpp"
#include "reservations/waitlist_manager.hpp"
#include "notifications/notification_service.hpp"
#include "config/config_loader.hpp"
#include <iostream>

int main() {
    CatalogConfig config = config_loader_default();
    CatalogStore store;
    store.catalog_store_add_book(Book("111", "Deep Waters", "A. Rivera"));
    store.catalog_store_add_book(Book("222", "Stone Paths", "B. Chen"));

    MemberRegistry registry;
    Member patron("m1", "Jamie Lin");
    registry.member_registry_add(patron);

    LoanLedger ledger;
    CalendarDate due{2026, 1, 15};
    Loan active_loan("111", "m1", due);
    ledger.loan_ledger_record(active_loan);

    CalendarDate today{2026, 2, 1};
    std::vector<Loan> active_loans{active_loan};
    std::vector<Loan> overdue = overdue_report_build(ledger, active_loans, today);

    SearchQuery query = catalog_core::search_query_parse("Stone");
    std::vector<Book> found = search_index_run(store, query);

    WaitlistManager waitlist;
    waitlist.waitlist_manager_enqueue("222", "m1");

    NotificationService notifier;
    if (!overdue.empty()) {
        notifier.notification_service_send(patron, overdue.front().loan_isbn());
    }

    std::cout << summary_report_build(store, registry) << std::endl;
    std::cout << "branch=" << config.branch_name << " matches=" << found.size() << std::endl;
    return 0;
}
