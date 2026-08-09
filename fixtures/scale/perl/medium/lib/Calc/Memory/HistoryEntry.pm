package Calc::Memory::HistoryEntry;
use strict;
use warnings;

sub new {
    my ($class, $expression, $value) = @_;
    return bless { expression => $expression, value => $value, stamp => time }, $class;
}

sub expression { return $_[0]->{expression} }
sub value      { return $_[0]->{value} }

sub format { return "$_[0]->{expression} => $_[0]->{value}" }

1;
