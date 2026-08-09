package Calc::Repl::HistoryCommand;
use strict;
use warnings;
use Calc::Output::TablePrinter;
use Calc::Output::NumberFormat;

sub run {
    my ($context, @parts) = @_;
    my $table = Calc::Output::TablePrinter->new('expression', 'value');
    for my $entry ($context->history->recent(10)) {
        $table->add_row($entry->expression, Calc::Output::NumberFormat::format($entry->value, $context->settings->precision));
    }
    return $table->render;
}

1;
