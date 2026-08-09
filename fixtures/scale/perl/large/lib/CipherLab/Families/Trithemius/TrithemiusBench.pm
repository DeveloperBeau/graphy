package CipherLab::Families::Trithemius::TrithemiusBench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::Trithemius::TrithemiusCipher;
use CipherLab::Families::Trithemius::TrithemiusVectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::Trithemius::TrithemiusCipher->new;
    my @vectors = CipherLab::Families::Trithemius::TrithemiusVectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
