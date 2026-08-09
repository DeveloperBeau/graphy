package Calc::Repl::VarsCommand;
use strict;
use warnings;
use Calc::Output::TablePrinter;
use Calc::Output::NumberFormat;

sub run {
    my ($context, @parts) = @_;
    my $table = Calc::Output::TablePrinter->new('name', 'value');
    for my $name ($context->environment->names) {
        my $value = $context->environment->resolve($name);
        $table->add_row($name, Calc::Output::NumberFormat::format($value, $context->settings->precision));
    }
    return $table->render;
}

1;
