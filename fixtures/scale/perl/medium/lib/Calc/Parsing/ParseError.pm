package Calc::Parsing::ParseError;
use strict;
use warnings;

sub new {
    my ($class, $message, $fragment) = @_;
    return bless { message => $message, fragment => $fragment }, $class;
}

sub message  { return $_[0]->{message} }
sub fragment { return $_[0]->{fragment} }

sub pretty { return "$_[0]->{message} near '$_[0]->{fragment}'" }

1;
