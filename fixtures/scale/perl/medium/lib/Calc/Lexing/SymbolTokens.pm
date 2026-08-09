package Calc::Lexing::SymbolTokens;
use strict;
use warnings;
use Calc::Lexing::Token;

my %SYMBOLS = ('(' => 'LPAREN', ')' => 'RPAREN', ',' => 'COMMA', '=' => 'EQUALS');

sub token_for {
    my ($ch) = @_;
    my $kind = $SYMBOLS{$ch} // 'OPERATOR';
    return Calc::Lexing::Token->new($kind, $ch);
}

1;
