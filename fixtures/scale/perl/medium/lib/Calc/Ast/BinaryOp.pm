package Calc::Ast::BinaryOp;
use strict;
use warnings;

sub new {
    my ($class, $op, $left, $right) = @_;
    return bless { kind => 'binary', op => $op, left => $left, right => $right }, $class;
}

sub op    { return $_[0]->{op} }
sub left  { return $_[0]->{left} }
sub right { return $_[0]->{right} }

sub describe {
    my ($self) = @_;
    return '(' . $self->left->describe . ' ' . $self->op . ' ' . $self->right->describe . ')';
}

1;
