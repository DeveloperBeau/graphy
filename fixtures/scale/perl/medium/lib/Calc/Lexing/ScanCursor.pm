package Calc::Lexing::ScanCursor;
use strict;
use warnings;

sub new {
    my ($class, $source) = @_;
    return bless { source => $source, position => 0 }, $class;
}

sub at_end { return $_[0]->{position} >= length($_[0]->{source}) }

sub peek {
    my ($self) = @_;
    return $self->at_end ? '' : substr($self->{source}, $self->{position}, 1);
}

sub advance {
    my ($self) = @_;
    my $ch = $self->peek;
    $self->{position}++;
    return $ch;
}

1;
