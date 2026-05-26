<?php
// feature: class, use imports, method, call edges
namespace App;

use App\Helpers;
use App\Greet;
use App\State;

class Service {
    private string $name;

    public function __construct(string $name) {
        $this->name = $name;
    }

    public function run(): string {
        $h = new Helpers();
        $greeting = $h->formatName($this->name);
        return $greeting;
    }

    public function describe(): string {
        return "Service({$this->name})";
    }
}
