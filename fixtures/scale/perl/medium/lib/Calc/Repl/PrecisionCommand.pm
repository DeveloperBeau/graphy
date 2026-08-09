package Calc::Repl::PrecisionCommand;
use strict;
use warnings;

sub run {
    my ($context, @parts) = @_;
    return 'precision is ' . $context->settings->{precision} unless @parts && $parts[0] =~ /^\d+$/;
    $context->settings->{precision} = $parts[0];
    return "precision set to $parts[0]";
}

1;
