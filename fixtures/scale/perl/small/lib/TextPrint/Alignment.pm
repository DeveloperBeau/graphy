package TextPrint::Alignment;
use strict;
use warnings;

sub align_line {
    my ($line, $width, $mode) = @_;
    my $slack = $width - length($line);
    return $line if $slack <= 0;
    if ($mode eq 'right') {
        return (' ' x $slack) . $line;
    }
    if ($mode eq 'center') {
        my $left = int($slack / 2);
        return (' ' x $left) . $line . (' ' x ($slack - $left));
    }
    return $line . (' ' x $slack);
}

1;
