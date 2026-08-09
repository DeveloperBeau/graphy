package CipherLab::VectorOutcome;
use strict;
use warnings;

sub new {
    my ($class, $family, $passed, $detail) = @_;
    return bless { family => $family, passed => $passed, detail => $detail }, $class;
}

sub family { return $_[0]->{family} }
sub passed { return $_[0]->{passed} }
sub detail { return $_[0]->{detail} }

1;
