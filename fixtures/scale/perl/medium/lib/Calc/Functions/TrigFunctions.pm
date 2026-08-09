package Calc::Functions::TrigFunctions;
use strict;
use warnings;
use POSIX qw(tan);

sub install {
    my ($registry) = @_;
    $registry->define('sin',  sub { sin($_[0]) });
    $registry->define('cos',  sub { cos($_[0]) });
    $registry->define('tan',  sub { tan($_[0]) });
    $registry->define('asin', sub { atan2($_[0], sqrt(1 - $_[0] ** 2)) });
}

1;
