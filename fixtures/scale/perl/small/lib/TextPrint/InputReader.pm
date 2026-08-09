package TextPrint::InputReader;
use strict;
use warnings;

sub read_all {
    my @lines;
    while (my $line = <STDIN>) {
        chomp $line;
        push @lines, $line;
    }
    return join ' ', @lines;
}

1;
