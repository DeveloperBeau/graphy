package CipherLab::Families::XorStatic::XorStaticRunner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::XorStatic::XorStaticCipher;
use CipherLab::Families::XorStatic::XorStaticVectors;

sub check {
    my $cipher = CipherLab::Families::XorStatic::XorStaticCipher->new;
    my @vectors = CipherLab::Families::XorStatic::XorStaticVectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
