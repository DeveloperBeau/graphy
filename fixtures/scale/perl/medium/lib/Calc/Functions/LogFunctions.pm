package Calc::Functions::LogFunctions;
use strict;
use warnings;
use POSIX qw(log10);

sub install {
    my ($registry) = @_;
    $registry->define('ln',    sub { log($_[0]) });
    $registry->define('log10', sub { log10($_[0]) });
    $registry->define('exp',   sub { exp($_[0]) });
}

1;
