#pragma once
#include <vector>
#include "circle.hpp"
#include "rectangle.hpp"
#include "triangle.hpp"

// A scene holds a small mixed collection of shapes and can total their area.
class Scene {
public:
    void scene_add_circle(const Circle& circle);
    void scene_add_rectangle(const Rectangle& rectangle);
    void scene_add_triangle(const Triangle& triangle);

    double scene_total_area() const;
    int scene_shape_count() const;

private:
    std::vector<Circle> circles_;
    std::vector<Rectangle> rectangles_;
    std::vector<Triangle> triangles_;
};
