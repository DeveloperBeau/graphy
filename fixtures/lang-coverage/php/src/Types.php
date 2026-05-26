<?php
// feature: interface, trait, enum
namespace App;

interface Greet {
    public function hi(): string;
}

trait Loggable {
    public function log(string $msg): void {
        echo $msg;
    }
}

enum State {
    case IDLE;
    case RUNNING;
    case DONE;
}
