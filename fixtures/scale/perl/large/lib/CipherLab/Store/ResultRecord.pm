package CipherLab::Store::ResultRecord;
use strict;
use warnings;

sub new {
    my ($class, $family, $suite, $passed) = @_;
    return bless { family => $family, suite => $suite, passed => $passed }, $class;
}

sub family { return $_[0]->{family} }

sub to_line {
    my ($self) = @_;
    return join("\t", $self->{family}, $self->{suite}, $self->{passed} ? 1 : 0);
}

sub from_line {
    my ($line) = @_;
    my ($family, $suite, $flag) = split /\t/, $line;
    return CipherLab::Store::ResultRecord->new($family, $suite, $flag eq '1');
}

1;
