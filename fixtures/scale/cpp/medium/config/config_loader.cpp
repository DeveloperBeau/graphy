#include "config_loader.hpp"

CatalogConfig config_loader_default() {
    CatalogConfig config;
    config.loan_period_days = 21;
    config.daily_fine_rate = 0.25;
    config.branch_name = "Central Branch";
    return config;
}
