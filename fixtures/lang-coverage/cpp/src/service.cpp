// feature: class inheriting BaseService, template function, namespace,
//          cross-file call (format_name), external call (cout must not produce local edge)
#include "types.hpp"
#include "helpers.hpp"
#include <iostream>
#include <map>

namespace graphy {

template<typename K, typename V>
V lookup(const std::map<K, V>& m, const K& k, V def) {
    auto it = m.find(k);
    return it != m.end() ? it->second : def;
}

class Service : public BaseService {
public:
    explicit Service(const std::string& name) : BaseService(name) {}
    ~Service() override = default;

    std::string hi() const override {
        return "hello from " + name_;
    }

    void run() {
        std::string greeting = format_name(name_);
        std::cout << greeting << std::endl;
    }
};

} // namespace graphy
