#include "point.hpp"
#include <cmath>

namespace geo {

double point_distance(const Point& a, const Point& b) {
    double dx = a.x - b.x;
    double dy = a.y - b.y;
    return std::sqrt(dx * dx + dy * dy);
}

} // namespace geo
