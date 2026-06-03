// Typed-layer coverage fixture for C++

struct Widget {
    int count;       // primitive field — no has_field edge
    Widget* next;    // self-ref pointer — has_field to extern::Widget
};

struct Holder {
    Widget item;     // non-primitive field (mandate 3)
};

class Processor {
public:
    Widget process(int n, Widget w) {  // inline body → function_definition path
        return w;                       // n is primitive (mandate 4); w at index 1 (mandate 5)
    }
};

// Free function: non-primitive return + non-primitive param (mandate 1)
Widget build(Widget w, int n) {
    return w;
}

// Primitive-then-non-primitive param ordering (mandate 5): index bite
Widget order(int n, Widget w) {
    return w;
}
