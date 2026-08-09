package Calc::Functions::SequenceFunctions;
use strict;
use warnings;

sub install {
    my ($registry) = @_;
    $registry->define('fact', sub { _factorial($_[0]) });
    $registry->define('fib',  sub { _fibonacci($_[0]) });
}

sub _factorial {
    my ($n) = @_;
    my $result = 1;
    $result *= $_ for 2 .. $n;
    return $result;
}

sub _fibonacci {
    my ($n) = @_;
    my ($a, $b) = (0, 1);
    ($a, $b) = ($b, $a + $b) for 1 .. $n;
    return $a;
}

1;
