package CipherLab::Families::Caesar::CaesarRunner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::Caesar::CaesarCipher;
use CipherLab::Families::Caesar::CaesarVectors;

sub check {
    my $cipher = CipherLab::Families::Caesar::CaesarCipher->new;
    my @vectors = CipherLab::Families::Caesar::CaesarVectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
