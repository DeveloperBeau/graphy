package Calc::Ast::VariableRef;
use strict;
use warnings;

sub new {
    my ($class, $name) = @_;
    return bless { kind => 'variable', name => $name }, $class;
}

sub name { return $_[0]->{name} }

sub describe { return $_[0]->{name} }

1;
