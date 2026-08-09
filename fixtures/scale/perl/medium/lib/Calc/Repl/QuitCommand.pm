package Calc::Repl::QuitCommand;
use strict;
use warnings;

sub run {
    my ($context, @parts) = @_;
    $context->settings->{running} = 0;
    return 'bye (' . $context->history->count . ' calculations this session)';
}

1;
