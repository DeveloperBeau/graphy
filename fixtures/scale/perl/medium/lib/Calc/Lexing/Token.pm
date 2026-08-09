package Calc::Lexing::Token;
use strict;
use warnings;

sub new {
    my ($class, $kind, $text) = @_;
    return bless { kind => $kind, text => $text }, $class;
}

sub kind { return $_[0]->{kind} }
sub text { return $_[0]->{text} }

sub number_value {
    my ($self) = @_;
    return $self->{text} + 0;
}

1;
