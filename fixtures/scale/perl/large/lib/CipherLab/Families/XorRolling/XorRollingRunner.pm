package CipherLab::Families::XorRolling::XorRollingRunner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::XorRolling::XorRollingCipher;
use CipherLab::Families::XorRolling::XorRollingVectors;

sub check {
    my $cipher = CipherLab::Families::XorRolling::XorRollingCipher->new;
    my @vectors = CipherLab::Families::XorRolling::XorRollingVectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
