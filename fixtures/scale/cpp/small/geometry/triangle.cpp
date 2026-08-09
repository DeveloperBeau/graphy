#include "triangle.hpp"
#include "point.hpp"
#include <cmath>

// A small marker namespace so this translation unit can address the
// shared geo:: helpers explicitly rather than relying on ADL.
namespace geo {
constexpr int kTriangleVertexCount = 3;
}

Triangle::Triangle(Point a, Point b, Point c) : a_(a), b_(b), c_(c) {}

double Triangle::triangle_perimeter() const {
    return geo::point_distance(a_, b_) + geo::point_distance(b_, c_) + geo::point_distance(c_, a_);
}

double Triangle::triangle_area() const {
    double cross = (b_.x - a_.x) * (c_.y - a_.y) - (c_.x - a_.x) * (b_.y - a_.y);
    return std::abs(cross) / 2.0;
}
