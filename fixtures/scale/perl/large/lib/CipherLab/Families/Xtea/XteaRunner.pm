package CipherLab::Families::Xtea::XteaRunner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::Xtea::XteaCipher;
use CipherLab::Families::Xtea::XteaVectors;

sub check {
    my $cipher = CipherLab::Families::Xtea::XteaCipher->new;
    my @vectors = CipherLab::Families::Xtea::XteaVectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
