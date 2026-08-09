#pragma once
#include <string>
#include "../geometry/shape_scene.hpp"

// Formats a short human-readable summary of a scene.
class ReportPrinter {
public:
    std::string report_printer_summarize(const Scene& scene) const;
    void report_printer_run(const Scene& scene) const;
};
