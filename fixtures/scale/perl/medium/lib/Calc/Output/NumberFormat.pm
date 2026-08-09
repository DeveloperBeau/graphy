package Calc::Output::NumberFormat;
use strict;
use warnings;

sub format {
    my ($value, $precision) = @_;
    return sprintf("%.${precision}f", $value);
}

1;
