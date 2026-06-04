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

// Generic-inner-type coverage. Forward declarations remove any type-vs-compare
// parse ambiguity; the methods live in a class so the `<...>` parse as template
// arguments (proven by the edge-count assertions in lang_cpp.rs).
struct Foo;
struct Bar;
template <class A, class B>
struct Pair;

class Generics {
public:
    // std::vector container is suppressed; the edge resolves to inner Widget.
    void take_vec(std::vector<Widget> items) {}

    // User generic Pair is NOT suppressed: edges to Pair, Foo AND Bar, all
    // sharing the single param index.
    void take_pair(Pair<Foo, Bar> p) {}
};
