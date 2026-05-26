// feature: class, struct, namespace, #include system
#pragma once
#include <string>

namespace graphy {

struct Point {
    int x;
    int y;
};

class BaseService {
public:
    explicit BaseService(const std::string& name) : name_(name) {}
    virtual ~BaseService() = default;
    virtual std::string hi() const = 0;

protected:
    std::string name_;
};

} // namespace graphy
