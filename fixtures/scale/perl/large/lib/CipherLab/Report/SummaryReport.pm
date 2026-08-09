package CipherLab::Report::SummaryReport;
use strict;
use warnings;
use CipherLab::Report::TableRenderer;

sub build {
    my ($prior_sessions, @outcomes) = @_;
    my $passed = grep { $_->passed } @outcomes;
    my $table = CipherLab::Report::TableRenderer->new;
    $table->row('metric', 'value');
    $table->row('families', scalar @outcomes);
    $table->row('passed', $passed);
    $table->row('prior sessions', $prior_sessions);
    return $table->render;
}

1;
