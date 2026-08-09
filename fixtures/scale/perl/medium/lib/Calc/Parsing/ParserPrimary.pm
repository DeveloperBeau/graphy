package Calc::Parsing::ParserPrimary;
use strict;
use warnings;
use Calc::Ast::NumberLiteral;
use Calc::Ast::VariableRef;
use Calc::Ast::FunctionCall;

sub parse_primary {
    my ($parser) = @_;
    my $token = $parser->{stream}->advance;
    return Calc::Ast::NumberLiteral->new($token->number_value) if $token->kind eq 'NUMBER';
    if ($token->kind eq 'LPAREN') {
        my $inner = $parser->parse_expression(1);
        $parser->{stream}->advance;
        return $inner;
    }
    if ($token->kind eq 'IDENT' && $parser->{stream}->current->kind eq 'LPAREN') {
        $parser->{stream}->advance;
        my @arguments = ($parser->parse_expression(1));
        while ($parser->{stream}->current->kind eq 'COMMA') {
            $parser->{stream}->advance;
            push @arguments, $parser->parse_expression(1);
        }
        $parser->{stream}->advance;
        return Calc::Ast::FunctionCall->new($token->text, @arguments);
    }
    return Calc::Ast::VariableRef->new($token->text);
}

1;
