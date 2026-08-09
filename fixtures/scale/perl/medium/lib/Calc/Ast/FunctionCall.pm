package Calc::Ast::FunctionCall;
use strict;
use warnings;

sub new {
    my ($class, $name, @arguments) = @_;
    return bless { kind => 'call', name => $name, arguments => [@arguments] }, $class;
}

sub name      { return $_[0]->{name} }
sub arguments { return @{ $_[0]->{arguments} } }

sub describe {
    my ($self) = @_;
    return $self->name . '(' . join(', ', map { $_->describe } $self->arguments) . ')';
}

1;
