// feature: extends, implements, all import styles, cross-file call, external call
package com.example;

import java.util.HashMap;
import java.util.*;
import static java.lang.Math.PI;

public class Service extends BaseService implements Greeter {
    private HashMap<String, String> cache;

    public Service(String name) {
        super(name);
        this.cache = new HashMap<>();
    }

    @Override
    public String hi() {
        return "hello from " + name;
    }

    public void run() {
        String greeting = Helpers.formatName(this.name);
        System.out.println(greeting);
    }
}
