<?php

namespace Calc;

class Version
{
    public const NUMBER = '1.4.2';

    public static function banner(): string
    {
        return 'calc ' . self::NUMBER . ' - type :help for commands';
    }
}
