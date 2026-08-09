package TextPrint::Border;
use strict;
use warnings;

sub new {
    my ($class, $style) = @_;
    my $horizontal = $style eq 'double' ? '=' : '-';
    return bless { horizontal => $horizontal }, $class;
}

sub frame {
    my ($self, $width, @lines) = @_;
    my $rule = '+' . ($self->{horizontal} x ($width + 2)) . '+';
    my @framed = ($rule);
    push @framed, "| $_ |" for @lines;
    push @framed, $rule;
    return @framed;
}

1;
