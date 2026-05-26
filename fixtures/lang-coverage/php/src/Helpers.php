<?php
// feature: class, function, method
namespace App;

class Helpers {
    public function formatName(string $name): string {
        return "hi, $name";
    }
}

function unrelated_helper(): int {
    return 7;
}
