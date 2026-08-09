#pragma once

// A circle described by its center and radius.
class Circle {
public:
    Circle(double center_x, double center_y, double radius);

    double circle_area() const;
    double circle_perimeter() const;
    double circle_radius() const;

private:
    double center_x_;
    double center_y_;
    double radius_;
};
