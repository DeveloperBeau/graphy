package CipherLab::Report::SuiteReport;
use strict;
use warnings;
use CipherLab::Report::TableRenderer;
use CipherLab::Registry::SuiteMap;

sub build {
    my (@outcomes) = @_;
    my %grouped = CipherLab::Registry::SuiteMap::grouped();
    my $table = CipherLab::Report::TableRenderer->new;
    $table->row('suite', 'families');
    for my $suite (CipherLab::Registry::SuiteMap::suite_names()) {
        $table->row($suite, scalar @{ $grouped{$suite} });
    }
    return $table->render;
}

1;
