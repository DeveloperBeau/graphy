package TextPrint::Theme;
use strict;
use warnings;
use TextPrint::AnsiPalette;

sub named {
    my ($name) = @_;
    my $prefix = '';
    $prefix = TextPrint::AnsiPalette::bold() if $name eq 'bright';
    $prefix = TextPrint::AnsiPalette::dim()  if $name eq 'mono';
    return bless { name => $name, prefix => $prefix }, __PACKAGE__;
}

sub apply {
    my ($self, $body) = @_;
    return $body unless length($self->{prefix});
    return $self->{prefix} . $body . TextPrint::AnsiPalette::reset();
}

1;
