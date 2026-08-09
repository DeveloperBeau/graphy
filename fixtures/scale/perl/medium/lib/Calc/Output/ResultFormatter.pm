package Calc::Output::ResultFormatter;
use strict;
use warnings;
use Calc::Output::NumberFormat;

sub format_result {
    my ($value, $settings) = @_;
    return '= ' . Calc::Output::NumberFormat::format($value, $settings->{precision});
}

sub format_error {
    my ($kind, $detail) = @_;
    return "! $kind: $detail";
}

1;
