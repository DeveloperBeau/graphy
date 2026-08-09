package Calc::Settings;
use strict;
use warnings;

sub interactive {
    return bless { precision => 6, running => 1 }, __PACKAGE__;
}

sub precision { return $_[0]->{precision} }

1;
