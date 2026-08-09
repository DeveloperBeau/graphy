package Calc::Ast::Assignment;
use strict;
use warnings;

sub new {
    my ($class, $name, $value) = @_;
    return bless { kind => 'assign', name => $name, value => $value }, $class;
}

sub name  { return $_[0]->{name} }
sub value { return $_[0]->{value} }

sub describe { return $_[0]->name . ' = ' . $_[0]->value->describe }

1;
