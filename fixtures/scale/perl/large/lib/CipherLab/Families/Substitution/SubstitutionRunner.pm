package CipherLab::Families::Substitution::SubstitutionRunner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::Substitution::SubstitutionCipher;
use CipherLab::Families::Substitution::SubstitutionVectors;

sub check {
    my $cipher = CipherLab::Families::Substitution::SubstitutionCipher->new;
    my @vectors = CipherLab::Families::Substitution::SubstitutionVectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
