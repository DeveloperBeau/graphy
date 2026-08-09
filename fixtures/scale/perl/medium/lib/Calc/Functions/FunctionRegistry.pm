package Calc::Functions::FunctionRegistry;
use strict;
use warnings;

sub new { return bless { table => {} }, shift }

sub define {
    my ($self, $name, $body) = @_;
    $self->{table}{$name} = $body;
}

sub invoke {
    my ($self, $name, @args) = @_;
    die "unknown function: $name\n" unless exists $self->{table}{$name};
    return $self->{table}{$name}->(@args);
}

sub names { return sort keys %{ $_[0]->{table} } }

1;
