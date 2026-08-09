package Calc::Functions::PowerFunctions;
use strict;
use warnings;

sub install {
    my ($registry) = @_;
    $registry->define('sqrt', sub { sqrt($_[0]) });
    $registry->define('cbrt', sub { $_[0] ** (1 / 3) });
    $registry->define('pow',  sub { $_[0] ** $_[1] });
}

1;
