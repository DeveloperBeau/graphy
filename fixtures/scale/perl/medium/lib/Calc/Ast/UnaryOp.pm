package Calc::Ast::UnaryOp;
use strict;
use warnings;

sub new {
    my ($class, $op, $operand) = @_;
    return bless { kind => 'unary', op => $op, operand => $operand }, $class;
}

sub op      { return $_[0]->{op} }
sub operand { return $_[0]->{operand} }

sub describe { return $_[0]->op . $_[0]->operand->describe }

1;
