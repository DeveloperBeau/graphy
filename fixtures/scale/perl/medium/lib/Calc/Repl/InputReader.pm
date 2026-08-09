package Calc::Repl::InputReader;
use strict;
use warnings;

sub new {
    my ($class, $prompt) = @_;
    return bless { prompt => $prompt }, $class;
}

sub next_line {
    my ($self) = @_;
    print $self->{prompt};
    my $line = <STDIN>;
    return $line;
}

1;
