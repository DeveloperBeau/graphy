<?php
// feature: typed signature layer (annotation-gated)
namespace App;

// (1) function with a typed non-primitive param + non-primitive return
// (2) an UNtyped param ($untyped) -> in signature.params with ty:null, no edge
// (3) a primitive-typed param (int $n) -> payload entry, no edge
function build(Widget $w, $untyped, int $n): Widget {
    return $w;
}

// (6) primitive-then-non-primitive ordering: $n is index 0 (primitive, no edge),
//     $w is index 1 (non-primitive, has_param with index=1)
class Processor {
    // (4) method inside a class with params
    public function process(int $n, Widget $w): string {
        return "x";
    }
}

// (5) typed property -> has_field edge to Widget; primitive property -> no edge
class Box {
    public Widget $item;
    public int $count;
}
