#include "shape_scene.hpp"

void Scene::scene_add_circle(const Circle& circle) {
    circles_.push_back(circle);
}

void Scene::scene_add_rectangle(const Rectangle& rectangle) {
    rectangles_.push_back(rectangle);
}

void Scene::scene_add_triangle(const Triangle& triangle) {
    triangles_.push_back(triangle);
}

double Scene::scene_total_area() const {
    double total = 0.0;
    for (const Circle& c : circles_) total += c.circle_area();
    for (const Rectangle& r : rectangles_) total += r.rectangle_area();
    for (const Triangle& t : triangles_) total += t.triangle_area();
    return total;
}

int Scene::scene_shape_count() const {
    return static_cast<int>(circles_.size() + rectangles_.size() + triangles_.size());
}
