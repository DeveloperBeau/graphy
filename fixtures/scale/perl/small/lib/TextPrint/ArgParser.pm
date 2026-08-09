package TextPrint::ArgParser;
use strict;
use warnings;
use TextPrint::Options;

sub parse {
    my (@args) = @_;
    my %opts;
    for (my $i = 0; $i < @args; $i++) {
        if    ($args[$i] eq '--width')  { $opts{width}       = $args[++$i] }
        elsif ($args[$i] eq '--align')  { $opts{align}       = $args[++$i] }
        elsif ($args[$i] eq '--border') { $opts{borderStyle} = $args[++$i] }
        elsif ($args[$i] eq '--theme')  { $opts{themeName}   = $args[++$i] }
    }
    return TextPrint::Options->new(%opts);
}

1;
