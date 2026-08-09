package CipherLab::BenchSample;
use strict;
use warnings;

sub new {
    my ($class, $family, $nanoseconds, $iterations) = @_;
    return bless { family => $family, nanoseconds => $nanoseconds, iterations => $iterations }, $class;
}

sub family { return $_[0]->{family} }

sub per_op {
    my ($self) = @_;
    return $self->{iterations} == 0 ? 0 : $self->{nanoseconds} / $self->{iterations};
}

1;
