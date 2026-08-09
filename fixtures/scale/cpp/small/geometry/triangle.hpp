#pragma once
#include "point.hpp"

// A triangle described by three vertices in the plane.
class Triangle {
public:
    Triangle(Point a, Point b, Point c);

    double triangle_perimeter() const;
    double triangle_area() const;

private:
    Point a_;
    Point b_;
    Point c_;
};
