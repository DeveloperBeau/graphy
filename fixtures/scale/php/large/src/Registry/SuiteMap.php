<?php

namespace CipherLab\Registry;

class SuiteMap
{
    public static function grouped(): array
    {
        $map = [];
        foreach (FamilyCatalog::all() as $descriptor) {
            $map[$descriptor->suite()][] = $descriptor;
        }
        return $map;
    }

    public static function suiteNames(): array
    {
        $names = array_keys(self::grouped());
        sort($names);
        return $names;
    }
}
