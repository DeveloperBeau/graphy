package CipherLab::Report::DurationFormat;
use strict;
use warnings;

sub per_op {
    my ($nanos) = @_;
    return sprintf('%.1fns', $nanos) if $nanos < 1000;
    return sprintf('%.1fus', $nanos / 1000);
}

1;
