<?php

namespace CipherLab\Cli;

class ArgParser
{
    public static function parse(array $args): Config
    {
        $config = Config::defaults();
        for ($i = 0; $i < count($args); $i++) {
            if ($args[$i] === '--iterations' && $i + 1 < count($args)) {
                $config->iterations = (int) $args[++$i];
            } elseif ($args[$i] === '--suite' && $i + 1 < count($args)) {
                $config->suiteFilter = $args[++$i];
            } elseif ($args[$i] === '--no-persist') {
                $config->persist = false;
            }
        }
        return $config;
    }
}
