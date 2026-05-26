// feature: class, method, import, constructor
package com.example

import java.util.Map
import java.util.ArrayList

class Service {
    String name

    Service(String name) {
        this.name = name
    }

    String run() {
        def helpers = new Helpers()
        def greeting = helpers.formatName(name)
        return greeting
    }

    String describe() {
        return "Service(${name})"
    }
}
