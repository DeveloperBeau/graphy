package Calc::Eval::Environment;
use strict;
use warnings;

sub new { return bless { variables => {} }, shift }

sub assign {
    my ($self, $name, $value) = @_;
    $self->{variables}{$name} = $value;
}

sub resolve {
    my ($self, $name) = @_;
    die "unknown variable: $name\n" unless exists $self->{variables}{$name};
    return $self->{variables}{$name};
}

sub names { return sort keys %{ $_[0]->{variables} } }

1;
