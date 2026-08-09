package Calc::Repl::CommandRouter;
use strict;
use warnings;
use Calc::Repl::HelpCommand;
use Calc::Repl::VarsCommand;
use Calc::Repl::HistoryCommand;
use Calc::Repl::PrecisionCommand;
use Calc::Repl::QuitCommand;

sub dispatch {
    my ($line, $context) = @_;
    my ($command, @rest) = split ' ', substr($line, 1);
    return Calc::Repl::HelpCommand::run($context, @rest)      if $command eq 'help';
    return Calc::Repl::VarsCommand::run($context, @rest)      if $command eq 'vars';
    return Calc::Repl::HistoryCommand::run($context, @rest)   if $command eq 'history';
    return Calc::Repl::PrecisionCommand::run($context, @rest) if $command eq 'precision';
    return Calc::Repl::QuitCommand::run($context, @rest)      if $command eq 'quit';
    return "unknown command :$command";
}

1;
