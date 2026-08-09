package CipherLab::Families::Substitution::SubstitutionBench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::Substitution::SubstitutionCipher;
use CipherLab::Families::Substitution::SubstitutionVectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::Substitution::SubstitutionCipher->new;
    my @vectors = CipherLab::Families::Substitution::SubstitutionVectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
