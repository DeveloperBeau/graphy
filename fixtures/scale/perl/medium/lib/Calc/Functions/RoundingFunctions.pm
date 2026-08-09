package Calc::Functions::RoundingFunctions;
use strict;
use warnings;
use POSIX qw(floor ceil);

sub install {
    my ($registry) = @_;
    $registry->define('round', sub { int($_[0] + ($_[0] >= 0 ? 0.5 : -0.5)) });
    $registry->define('floor', sub { floor($_[0]) });
    $registry->define('ceil',  sub { ceil($_[0]) });
}

1;
