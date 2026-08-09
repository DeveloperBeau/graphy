package TextPrint::Wrapper;
use strict;
use warnings;

sub wrap {
    my ($text, $width) = @_;
    my @lines;
    my $current = '';
    for my $word (split / /, $text) {
        if (length($current) && length($current) + length($word) + 1 > $width) {
            push @lines, $current;
            $current = $word;
        } else {
            $current = length($current) ? "$current $word" : $word;
        }
    }
    push @lines, $current if length($current);
    return @lines;
}

1;
