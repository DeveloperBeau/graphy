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
