#include "circle.hpp"
#include <cmath>

namespace {
constexpr double kPi = 3.14159265358979323846;
}

Circle::Circle(double center_x, double center_y, double radius)
    : center_x_(center_x), center_y_(center_y), radius_(radius) {}

double Circle::circle_area() const {
    return kPi * radius_ * radius_;
}

double Circle::circle_perimeter() const {
    return 2.0 * kPi * radius_;
}

double Circle::circle_radius() const {
    return radius_;
}
