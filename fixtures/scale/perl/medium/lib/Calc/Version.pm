package Calc::Version;
use strict;
use warnings;

use constant NUMBER => '1.4.2';

sub banner {
    return 'calc ' . NUMBER . ' - type :help for commands';
}

1;
