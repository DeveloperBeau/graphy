#include "report_printer.hpp"
#include <iostream>
#include <sstream>

std::string ReportPrinter::report_printer_summarize(const Scene& scene) const {
    std::ostringstream out;
    out << "shapes=" << scene.scene_shape_count()
        << " total_area=" << scene.scene_total_area();
    return out.str();
}

void ReportPrinter::report_printer_run(const Scene& scene) const {
    std::cout << report_printer_summarize(scene) << std::endl;
}
