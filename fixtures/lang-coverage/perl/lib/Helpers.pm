package Helpers;

use strict;
use warnings;

our @EXPORT = qw(format_name);

sub format_name {
    my ($name) = @_;
    return "hi, $name";
}

sub unrelated_helper {
    return 7;
}

1;
