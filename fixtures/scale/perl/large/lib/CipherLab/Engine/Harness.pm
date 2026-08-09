package CipherLab::Engine::Harness;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Registry::FamilyCatalog;

sub run_all {
    my ($reporter) = @_;
    my @outcomes;
    for my $descriptor (CipherLab::Registry::FamilyCatalog::all()) {
        my $outcome = CipherLab::Engine::CorrectnessEngine::verify($descriptor->cipher, $descriptor->vectors);
        $reporter->step($descriptor->family, $outcome->passed);
        push @outcomes, $outcome;
    }
    return @outcomes;
}

1;
