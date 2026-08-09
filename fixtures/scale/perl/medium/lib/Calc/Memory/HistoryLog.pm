package Calc::Memory::HistoryLog;
use strict;
use warnings;
use Calc::Memory::HistoryEntry;

sub new { return bless { entries => [] }, shift }

sub append {
    my ($self, $expression, $value) = @_;
    my $entry = Calc::Memory::HistoryEntry->new($expression, $value);
    push @{ $self->{entries} }, $entry;
    return $entry;
}

sub recent {
    my ($self, $count) = @_;
    my @entries = @{ $self->{entries} };
    my $start = @entries > $count ? @entries - $count : 0;
    return @entries[$start .. $#entries];
}

sub count { return scalar @{ $_[0]->{entries} } }

1;
