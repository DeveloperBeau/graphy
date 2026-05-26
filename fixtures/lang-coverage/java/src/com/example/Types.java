// feature: class, interface, enum, record
package com.example;

public interface Greeter {
    String hi();
}

public enum State { IDLE, RUNNING, DONE }

public record Point(int x, int y) {}

public class BaseService {
    protected String name;

    public BaseService(String name) {
        this.name = name;
    }
}
