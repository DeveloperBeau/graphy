package CipherLab::Report::TableRenderer;
use strict;
use warnings;

sub new { return bless { rows => [] }, shift }

sub row {
    my ($self, @cells) = @_;
    push @{ $self->{rows} }, [@cells];
}

sub render {
    my ($self) = @_;
    return join "\n", map { join('  ', @$_) } @{ $self->{rows} };
}

1;
