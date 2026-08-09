package CipherLab::Store::SessionState;
use strict;
use warnings;
use CipherLab::Store::ResultsStore;

sub previous_sessions {
    my @runs = CipherLab::Store::ResultsStore::prior_runs();
    my %families = map { $_->family => 1 } @runs;
    my $count = scalar keys %families;
    return $count == 0 ? 0 : int(scalar(@runs) / $count);
}

1;
