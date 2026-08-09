#include "rectangle.hpp"
#include <cmath>

Rectangle::Rectangle(double width, double height)
    : width_(width), height_(height) {}

double Rectangle::rectangle_area() const {
    return width_ * height_;
}

double Rectangle::rectangle_perimeter() const {
    return 2.0 * (width_ + height_);
}

bool Rectangle::rectangle_is_square() const {
    return std::abs(width_ - height_) < 1e-9;
}
