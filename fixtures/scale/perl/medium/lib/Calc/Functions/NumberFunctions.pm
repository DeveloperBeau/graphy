package Calc::Functions::NumberFunctions;
use strict;
use warnings;

sub install {
    my ($registry) = @_;
    $registry->define('abs',   sub { abs($_[0]) });
    $registry->define('sign',  sub { $_[0] <=> 0 });
    $registry->define('clamp', sub { my ($x, $lo, $hi) = @_; $x < $lo ? $lo : $x > $hi ? $hi : $x });
}

1;
