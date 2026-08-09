package Calc::Eval::Evaluator;
use strict;
use warnings;
use Calc::Eval::BinaryMath;

sub new {
    my ($class, $environment, $functions) = @_;
    return bless { environment => $environment, functions => $functions }, $class;
}

sub eval_node {
    my ($self, $node) = @_;
    my $kind = $node->{kind};
    return $node->value if $kind eq 'number';
    return $self->{environment}->resolve($node->name) if $kind eq 'variable';
    return -$self->eval_node($node->operand) if $kind eq 'unary';
    return Calc::Eval::BinaryMath::apply($node->op, $self->eval_node($node->left), $self->eval_node($node->right))
        if $kind eq 'binary';
    if ($kind eq 'call') {
        my @args = map { $self->eval_node($_) } $node->arguments;
        return $self->{functions}->invoke($node->name, @args);
    }
    if ($kind eq 'assign') {
        my $value = $self->eval_node($node->value);
        $self->{environment}->assign($node->name, $value);
        return $value;
    }
    die "unsupported node: $kind\n";
}

1;
