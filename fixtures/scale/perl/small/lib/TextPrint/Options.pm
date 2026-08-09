package TextPrint::Options;
use strict;
use warnings;

sub new {
    my ($class, %args) = @_;
    my $self = {
        width       => $args{width}       // 60,
        align       => $args{align}       // 'left',
        borderStyle => $args{borderStyle} // 'single',
        themeName   => $args{themeName}   // 'plain',
    };
    return bless $self, $class;
}

sub width       { return $_[0]->{width} }
sub align       { return $_[0]->{align} }
sub borderStyle { return $_[0]->{borderStyle} }
sub themeName   { return $_[0]->{themeName} }

1;
