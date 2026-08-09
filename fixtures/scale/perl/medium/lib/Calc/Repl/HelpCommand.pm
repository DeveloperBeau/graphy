package Calc::Repl::HelpCommand;
use strict;
use warnings;

sub run {
    my ($context, @parts) = @_;
    my $names = join ', ', $context->functions->names;
    return join "\n",
        'commands: :help :vars :history :precision N :quit',
        "functions: $names",
        'assign with  name = expression';
}

1;
