#include "geometry/circle.hpp"
#include "geometry/rectangle.hpp"
#include "geometry/triangle.hpp"
#include "geometry/shape_scene.hpp"
#include "report/report_printer.hpp"

int main() {
    Scene scene;
    scene.scene_add_circle(Circle(0.0, 0.0, 3.0));
    scene.scene_add_rectangle(Rectangle(4.0, 5.0));
    scene.scene_add_triangle(Triangle(Point{0.0, 0.0}, Point{4.0, 0.0}, Point{0.0, 3.0}));

    ReportPrinter printer;
    printer.report_printer_run(scene);
    return 0;
}
