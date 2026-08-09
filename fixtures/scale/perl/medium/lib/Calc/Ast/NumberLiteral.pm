package Calc::Ast::NumberLiteral;
use strict;
use warnings;

sub new {
    my ($class, $value) = @_;
    return bless { kind => 'number', value => $value }, $class;
}

sub value { return $_[0]->{value} }

sub describe { return "$_[0]->{value}" }

1;
