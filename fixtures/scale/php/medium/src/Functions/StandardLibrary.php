<?php

namespace Calc\Functions;

require_once __DIR__ . '/FunctionRegistry.php';
require_once __DIR__ . '/TrigFunctions.php';
require_once __DIR__ . '/HyperbolicFunctions.php';
require_once __DIR__ . '/LogFunctions.php';
require_once __DIR__ . '/PowerFunctions.php';
require_once __DIR__ . '/RoundingFunctions.php';
require_once __DIR__ . '/StatsFunctions.php';
require_once __DIR__ . '/NumberFunctions.php';
require_once __DIR__ . '/SequenceFunctions.php';

class StandardLibrary
{
    public static function buildRegistry(): FunctionRegistry
    {
        $registry = new FunctionRegistry();
        TrigFunctions::install($registry);
        HyperbolicFunctions::install($registry);
        LogFunctions::install($registry);
        PowerFunctions::install($registry);
        RoundingFunctions::install($registry);
        StatsFunctions::install($registry);
        NumberFunctions::install($registry);
        SequenceFunctions::install($registry);
        return $registry;
    }
}
