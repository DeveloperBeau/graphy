#pragma once
#include <string>

// Holds a handful of catalog-wide settings loaded once at startup.
struct CatalogConfig {
    int loan_period_days;
    double daily_fine_rate;
    std::string branch_name;
};

CatalogConfig config_loader_default();
