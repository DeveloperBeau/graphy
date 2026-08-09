package Calc::Eval::EvalError;
use strict;
use warnings;

sub new {
    my ($class, $message, $subject) = @_;
    return bless { message => $message, subject => $subject }, $class;
}

sub message { return $_[0]->{message} }
sub subject { return $_[0]->{subject} }

sub pretty { return "$_[0]->{message}: $_[0]->{subject}" }

1;
