package Calc::Parsing::Parser;
use strict;
use warnings;
use Calc::Parsing::TokenStream;
use Calc::Parsing::Precedence;
use Calc::Parsing::ParserPrimary;
use Calc::Ast::Assignment;
use Calc::Ast::BinaryOp;

sub new {
    my ($class, $source) = @_;
    return bless { stream => Calc::Parsing::TokenStream->new($source) }, $class;
}

sub parse_statement {
    my ($self) = @_;
    if ($self->{stream}->looks_like_assignment) {
        my $name = $self->{stream}->advance->text;
        $self->{stream}->advance;
        return Calc::Ast::Assignment->new($name, $self->parse_expression(1));
    }
    return $self->parse_expression(1);
}

sub parse_expression {
    my ($self, $min_precedence) = @_;
    my $left = Calc::Parsing::ParserPrimary::parse_primary($self);
    while ($self->{stream}->current->kind eq 'OPERATOR'
        && Calc::Parsing::Precedence::of($self->{stream}->current->text) >= $min_precedence) {
        my $op = $self->{stream}->advance->text;
        my $next = Calc::Parsing::Precedence::right_associative($op)
            ? Calc::Parsing::Precedence::of($op) : Calc::Parsing::Precedence::of($op) + 1;
        $left = Calc::Ast::BinaryOp->new($op, $left, $self->parse_expression($next));
    }
    return $left;
}

1;
