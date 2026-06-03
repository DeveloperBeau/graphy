// Coverage fixture for the typed signature layer.
// tree-sitter parse only; no compiler required.

class Widget {
    label: string;
    owner: Person;
}

class Person {
    name: string;
}

class Svc {
    pet: Widget;
}

function build(count: number, pet: Widget): Widget {
    return pet;
}

function order(pet: Widget, n: number): Widget {
    return pet;
}

class Processor {
    process(n: number, visitor: Widget): Widget {
        return visitor;
    }
}

interface Shape {
    color: string;
    area: Widget;
}

class Foo {
    name: string;
}

class Bar {
    name: string;
}

// Stdlib generic container over a custom type: only Widget gets an edge.
function collect(items: Array<Widget>): void {}

// User two-arg generic over two custom types: Pair, Foo and Bar all get edges
// sharing the same parameter index.
function pair(p: Pair<Foo, Bar>): void {}

// Bare custom type: exactly one has_param edge (regression).
function single(w: Widget): void {}

// Union type: both members get edges sharing the same parameter index.
function u(x: Foo | Bar): void {}
