package Calc::Lexing::Lexer;
use strict;
use warnings;
use Calc::Lexing::ScanCursor;
use Calc::Lexing::Token;
use Calc::Lexing::SymbolTokens;

sub new {
    my ($class, $source) = @_;
    return bless { cursor => Calc::Lexing::ScanCursor->new($source) }, $class;
}

sub next_token {
    my ($self) = @_;
    my $cursor = $self->{cursor};
    $cursor->advance while !$cursor->at_end && $cursor->peek =~ /\s/;
    return Calc::Lexing::Token->new('END', '') if $cursor->at_end;
    my $ch = $cursor->peek;
    return $self->_read_while('NUMBER', qr/[0-9.]/) if $ch =~ /[0-9]/;
    return $self->_read_while('IDENT', qr/[A-Za-z]/) if $ch =~ /[A-Za-z]/;
    $cursor->advance;
    return Calc::Lexing::SymbolTokens::token_for($ch);
}

sub _read_while {
    my ($self, $kind, $pattern) = @_;
    my $cursor = $self->{cursor};
    my $text = '';
    $text .= $cursor->advance while !$cursor->at_end && $cursor->peek =~ $pattern;
    return Calc::Lexing::Token->new($kind, $text);
}

1;
