#pragma once

// An axis-aligned rectangle defined by width and height.
class Rectangle {
public:
    Rectangle(double width, double height);

    double rectangle_area() const;
    double rectangle_perimeter() const;
    bool rectangle_is_square() const;

private:
    double width_;
    double height_;
};
