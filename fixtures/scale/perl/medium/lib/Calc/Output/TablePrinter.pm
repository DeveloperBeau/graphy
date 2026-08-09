package Calc::Output::TablePrinter;
use strict;
use warnings;

sub new {
    my ($class, @headers) = @_;
    return bless { headers => [@headers], rows => [] }, $class;
}

sub add_row {
    my ($self, @cells) = @_;
    push @{ $self->{rows} }, [@cells];
}

sub render {
    my ($self) = @_;
    my @lines = (join ' | ', @{ $self->{headers} });
    push @lines, join ' | ', @$_ for @{ $self->{rows} };
    return join "\n", @lines;
}

1;
