// feature: typed signature layer
package com.example;

// (1) + (3) Class with non-primitive field (has_field edge to Widget)
//           + primitive field (no has_field edge)
public class Box {
    private Widget item;  // non-primitive: has_field -> extern::Widget
    private int count;     // primitive: no has_field edge
}

// (2) Method inside class with params (primitive + non-primitive, index ordering)
public class Processor {
    // (4) primitive param n at index 0 -> no has_param edge
    // (5) non-primitive param w at index 1 -> has_param with index=1
    public Widget process(int n, Widget w) {
        return w;
    }
}

// (1) Method with non-primitive param + non-primitive return
public class Builder {
    public Widget build(Widget w, int n) {
        return w;
    }
}

// (6) Generic inner types: container is suppressed, inner types get edges
public class Collector {
    // List<Widget> -> has_param to Widget only (List suppressed), index 0
    // Pair<Foo, Bar> -> Pair (user type), Foo, Bar all share index 1
    public void collect(List<Widget> items, Pair<Foo, Bar> p) {
    }
}
