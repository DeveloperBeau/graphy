package Calc::Repl::Repl;
use strict;
use warnings;
use Calc::Parsing::Parser;
use Calc::Eval::Evaluator;
use Calc::Repl::InputReader;
use Calc::Repl::CommandRouter;
use Calc::Output::ResultFormatter;

sub new {
    my ($class, $context) = @_;
    return bless { context => $context, reader => Calc::Repl::InputReader->new('calc> ') }, $class;
}

sub run {
    my ($self) = @_;
    my $context = $self->{context};
    my $evaluator = Calc::Eval::Evaluator->new($context->environment, $context->functions);
    while ($context->settings->{running} && defined(my $line = $self->{reader}->next_line)) {
        chomp $line;
        next unless length $line;
        if ($line =~ /^:/) {
            print Calc::Repl::CommandRouter::dispatch($line, $context), "\n";
            next;
        }
        my $node = Calc::Parsing::Parser->new($line)->parse_statement;
        my $value = $evaluator->eval_node($node);
        $context->history->append($line, $value);
        print Calc::Output::ResultFormatter::format_result($value, $context->settings), "\n";
    }
}

1;
