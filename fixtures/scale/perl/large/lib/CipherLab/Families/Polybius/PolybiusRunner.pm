package CipherLab::Families::Polybius::PolybiusRunner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::Polybius::PolybiusCipher;
use CipherLab::Families::Polybius::PolybiusVectors;

sub check {
    my $cipher = CipherLab::Families::Polybius::PolybiusCipher->new;
    my @vectors = CipherLab::Families::Polybius::PolybiusVectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
