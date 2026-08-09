package Calc::Functions::StatsFunctions;
use strict;
use warnings;
use List::Util qw(min max sum);

sub install {
    my ($registry) = @_;
    $registry->define('min',  sub { min(@_) });
    $registry->define('max',  sub { max(@_) });
    $registry->define('sum',  sub { sum(@_) });
    $registry->define('mean', sub { sum(@_) / scalar(@_) });
}

1;
