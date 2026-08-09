<?php

namespace CipherLab\Report;

use CipherLab\Registry\SuiteMap;

class SuiteReport
{
    public function build(array $outcomes): string
    {
        $table = new TableRenderer();
        $table->row(['suite', 'families']);
        $grouped = SuiteMap::grouped();
        foreach (SuiteMap::suiteNames() as $suite) {
            $table->row([$suite, (string) count($grouped[$suite])]);
        }
        return $table->render();
    }
}
