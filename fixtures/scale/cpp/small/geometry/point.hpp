#pragma once

// A plain 2D coordinate used by the shapes that need vertex math.
struct Point {
    double x;
    double y;
};

// Shared geometry helpers usable by any shape that needs vertex math.
namespace geo {
double point_distance(const Point& a, const Point& b);
}
